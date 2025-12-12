// lib/services/ble/movesense_connect.dart

import 'dart:convert';
import 'package:mdsflutter/Mds.dart';
import '../../core/logger.dart';
import '../../core/app_config.dart';
import '../../models/hr_packet.dart';
import '../../models/imu_packet.dart';

typedef HrCallback = void Function(HrPacket packet);
typedef ImuCallback = void Function(ImuPacket packet, {bool isSync});
typedef StatusCallback = void Function(String serial, bool connected);

class MovesenseConnect {
  static final MovesenseConnect _instance = MovesenseConnect._();
  static MovesenseConnect get i => _instance;
  MovesenseConnect._();

  final Set<String> _connectedDevices = {};
  final Set<String> _imuSyncSent = {};

  HrCallback? onHrData;
  ImuCallback? onImuData;
  StatusCallback? onStatusChange;

  bool isConnected(String serial) => _connectedDevices.contains(serial);

  void connect(String serial) {
    final short = _shortId(serial);
    _imuSyncSent.remove(serial);
    
    Logger.i.info('Connect', 'Attempting connection to $short');

    Mds.connect(
      serial,
      (_) {
        Logger.i.info('Connect', 'Connected to $short');
        _connectedDevices.add(serial);
        onStatusChange?.call(serial, true);
        _subscribeAll(serial);
      },
      () {
        Logger.i.warning('Connect', 'Disconnected from $short - retrying in 3s');
        _connectedDevices.remove(serial);
        onStatusChange?.call(serial, false);
        Future.delayed(AppConfig.reconnectDelay, () => connect(serial));
      },
      (error) {
        Logger.i.error('Connect', 'Connection error $short: $error');
        Future.delayed(AppConfig.reconnectDelay, () => connect(serial));
      },
      (_) {},
    );
  }

  void disconnect(String serial) {
    final short = _shortId(serial);
    Logger.i.info('Connect', 'Disconnecting from $short');
    Mds.disconnect(serial);
    _connectedDevices.remove(serial);
    _imuSyncSent.remove(serial);
    onStatusChange?.call(serial, false);
  }

  void disconnectAll() {
    for (final serial in _connectedDevices.toList()) {
      disconnect(serial);
    }
  }

  void _subscribeAll(String serial) {
    _subscribeHr(serial);
    _subscribeImu(serial);
  }

  void _subscribeHr(String serial) {
    final short = _shortId(serial);

    Mds.subscribe(
      Mds.createSubscriptionUri(serial, '/Meas/HR'),
      '{}',
      (_, __) => Logger.i.info('Subscribe', 'HR subscription OK for $short'),
      (_, error) => Logger.i.error('Subscribe', 'HR subscription error: $error'),
      (notification) {
        try {
          final decoded = jsonDecode(notification) as Map<String, dynamic>;
          final body = decoded['Body'] as Map<String, dynamic>;

          final packet = HrPacket.fromRaw(
            sensorId: serial,
            sessionId: AppConfig.sessionId,
            gatewayTime: DateTime.now().millisecondsSinceEpoch,
            body: body,
          );

          Logger.i.debug('HR', 'Received from $short: ${packet.average} BPM');
          onHrData?.call(packet);
        } catch (e) {
          Logger.i.error('HR', 'Decode error: $e');
        }
      },
      (_, error) => Logger.i.error('Subscribe', 'HR stream error: $error'),
    );
  }

  void _subscribeImu(String serial) {
    final short = _shortId(serial);

    Mds.subscribe(
      Mds.createSubscriptionUri(serial, '/Meas/IMU9/${AppConfig.imuSampleRate}'),
      '{}',
      (_, __) => Logger.i.info('Subscribe', 'IMU subscription OK for $short'),
      (_, error) => Logger.i.error('Subscribe', 'IMU subscription error: $error'),
      (notification) {
        try {
          final decoded = jsonDecode(notification) as Map<String, dynamic>;
          final body = decoded['Body'] as Map<String, dynamic>;
          final now = DateTime.now().millisecondsSinceEpoch;

          final isSync = !_imuSyncSent.contains(serial);
          if (isSync) {
            _imuSyncSent.add(serial);
            Logger.i.info('IMU', 'Sync packet sent for $short');
          }

          final packet = ImuPacket.fromRaw(
            sensorId: serial,
            sessionId: AppConfig.sessionId,
            gatewayTime: isSync ? now : null,
            body: body,
          );

          Logger.i.debug('IMU', 'Received from $short: ts=${packet.timestamp}');
          onImuData?.call(packet, isSync: isSync);
        } catch (e) {
          Logger.i.error('IMU', 'Decode error: $e');
        }
      },
      (_, error) => Logger.i.error('Subscribe', 'IMU stream error: $error'),
    );
  }

  String _shortId(String serial) {
    return serial.length >= 8 ? serial.substring(serial.length - 8) : serial;
  }
}

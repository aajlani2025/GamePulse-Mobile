// lib/services/ble/movesense_scanner.dart

import 'package:mdsflutter/Mds.dart';
import '../../core/logger.dart';

class MovesenseScanner {
  static final MovesenseScanner _instance = MovesenseScanner._();
  static MovesenseScanner get i => _instance;
  MovesenseScanner._();

  bool _isScanning = false;
  bool get isScanning => _isScanning;

  void startScan({
    required void Function(String name, String serial) onDeviceFound,
  }) {
    if (_isScanning) return;

    _isScanning = true;
    Logger.i.info('Scanner', 'Starting BLE scan...');

    Mds.startScan((name, serial) {


      
      if (serial == null || serial.isEmpty) return;
      Logger.i.info('Scanner', 'Device found: $name | ${_shortId(serial)}');
      onDeviceFound(name ?? 'Unknown', serial);
    });
  }

  void stopScan() {
    if (!_isScanning) return;

    _isScanning = false;
    Logger.i.info('Scanner', 'Stopping BLE scan');
    Mds.stopScan();
  }

  String _shortId(String serial) {
    return serial.length >= 8 ? serial.substring(serial.length - 8) : serial;
  }
}

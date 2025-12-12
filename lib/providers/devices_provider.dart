// lib/providers/devices_provider.dart

import 'package:flutter/foundation.dart';
import '../models/sensor_device.dart';

class DevicesProvider extends ChangeNotifier {
  final Map<String, SensorDevice> _devices = {};

  List<SensorDevice> get devices => _devices.values.toList();
  List<SensorDevice> get connectedDevices =>
      _devices.values.where((d) => d.isConnected).toList();
  int get deviceCount => _devices.length;
  int get connectedCount => connectedDevices.length;

  SensorDevice? getDevice(String serial) => _devices[serial];

  void addDevice(SensorDevice device) {
    _devices[device.serial] = device;
    notifyListeners();
  } 

  void updateDeviceStatus(String serial, DeviceStatus status) {
    final device = _devices[serial];
    if (device != null) {
      _devices[serial] = device.copyWith(status: status, lastSeen: DateTime.now());
      notifyListeners();
    }
  }

  void updateHeartRate(String serial, int hr) {
    final device = _devices[serial];
    if (device != null) {
      _devices[serial] = device.copyWith(lastHeartRate: hr, lastSeen: DateTime.now());
      notifyListeners();
    }
  }

  void removeDevice(String serial) {
    _devices.remove(serial);
    notifyListeners();
  }

  void clearAll() {
    _devices.clear();
    notifyListeners();
  }
}

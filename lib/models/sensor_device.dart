// lib/models/sensor_device.dart

enum DeviceStatus { disconnected, connecting, connected, error }

class SensorDevice {
  final String serial;
  final String name;
  final String shortId;
  final DeviceStatus status;
  final int? lastHeartRate;
  final DateTime? lastSeen;

  SensorDevice({
    required this.serial,
    required this.name,
    this.status = DeviceStatus.disconnected,
    this.lastHeartRate,
    this.lastSeen,
  }) : shortId = serial.length >= 8 ? serial.substring(serial.length - 8) : serial;

  bool get isConnected => status == DeviceStatus.connected;

  SensorDevice copyWith({
    DeviceStatus? status,
    int? lastHeartRate,
    DateTime? lastSeen,
  }) {
    return SensorDevice(
      serial: serial,
      name: name,
      status: status ?? this.status,
      lastHeartRate: lastHeartRate ?? this.lastHeartRate,
      lastSeen: lastSeen ?? this.lastSeen,
    );
  }
}

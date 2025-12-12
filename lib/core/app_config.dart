// lib/core/app_config.dart

class AppConfig {
  static const String wsImuUrl = 'ws://192.168.1.50:3000/imu';
  static const String wsHrUrl = 'ws://192.168.1.50:3000/hr';
  static const Duration reconnectDelay = Duration(seconds: 3);
  static const int imuSampleRate = 104;

  static String get sessionId => DateTime.now()
      .toUtc()
      .toIso8601String()
      .substring(0, 19) + 'Z';
}

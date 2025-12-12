// lib/services/time/timestamp_service.dart

class TimestampService {
  static int now() => DateTime.now().millisecondsSinceEpoch;

  static String sessionId() {
    return '${DateTime.now().toUtc().toIso8601String().substring(0, 19)}Z';
  }
}

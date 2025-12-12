// lib/models/session_event.dart

class SessionEvent {
  final String type;
  final DateTime timestamp;
  final String? message;

  SessionEvent({
    required this.type,
    this.message,
  }) : timestamp = DateTime.now();
}

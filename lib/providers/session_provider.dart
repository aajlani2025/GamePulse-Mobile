// lib/providers/session_provider.dart

import 'package:flutter/foundation.dart';

class SessionProvider extends ChangeNotifier {
  bool _isActive = false;
  DateTime? _startTime;

  bool get isActive => _isActive;
  DateTime? get startTime => _startTime;

  void start() {
    _isActive = true;
    _startTime = DateTime.now();
    notifyListeners();
  }

  void stop() {
    _isActive = false;
    notifyListeners();
  }
}

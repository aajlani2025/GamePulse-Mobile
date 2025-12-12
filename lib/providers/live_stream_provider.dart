// lib/providers/live_stream_provider.dart

import 'package:flutter/foundation.dart';

class LiveStreamProvider extends ChangeNotifier {
  bool _isStreaming = false;

  bool get isStreaming => _isStreaming;

  void start() {
    _isStreaming = true;
    notifyListeners();
  }

  void stop() {
    _isStreaming = false;
    notifyListeners();
  }
}

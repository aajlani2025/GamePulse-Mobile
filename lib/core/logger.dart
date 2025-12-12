// lib/core/logger.dart

class Logger {
  static final Logger _instance = Logger._();
  static Logger get i => _instance;
  Logger._();

  void debug(String tag, String message) => print('[DEBUG][$tag] $message');
  void info(String tag, String message) => print('[INFO][$tag] $message');
  void warning(String tag, String message) => print('[WARN][$tag] $message');
  void error(String tag, String message) => print('[ERROR][$tag] $message');
}

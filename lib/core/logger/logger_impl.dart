import 'package:injectable/injectable.dart';

import 'app_logger.dart';
import 'trees/log_tree.dart';

@LazySingleton(as: AppLogger)
class LoggerImpl implements AppLogger {
  final List<LogTree> trees;

  LoggerImpl(this.trees);

  @override
  void debug(String message, {Object? error, StackTrace? stackTrace}) {
    _log(LogLevel.debug, message, error, stackTrace);
  }

  @override
  void info(String message, {Object? error, StackTrace? stackTrace}) {
    _log(LogLevel.info, message, error, stackTrace);
  }

  @override
  void warning(String message, {Object? error, StackTrace? stackTrace}) {
    _log(LogLevel.warning, message, error, stackTrace);
  }

  @override
  void error(String message, {Object? error, StackTrace? stackTrace}) {
    _log(LogLevel.error, message, error, stackTrace);
  }

  void _log(
    LogLevel level,
    String message,
    Object? error,
    StackTrace? stackTrace,
  ) {
    for (final tree in trees) {
      tree.log(level, message, error: error, stackTrace: stackTrace);
    }
  }
}

import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _logger = Logger(
    printer: CustomLogPrinter(), // Uses a custom log printer
  );

  /// **Trace (`t`)** → Used for detailed debugging, such as error stack traces or deep analysis.
  /// Example: `AppLogger.t('Error fetching data', stacktrace);`
  static void t(String message, [StackTrace? stackTrace]) {
    // You can log the stack trace directly in the message, or pass it as an error.
    if (stackTrace != null) {
      _logger.t('$message\nStackTrace: $stackTrace');
    } else {
      _logger.t(message);
    }
  }

  /// **Debug (`d`)** → Used for general debugging during development.
  /// Example: `AppLogger.d('Fetching data from API');`
  static void d(String message) {
    _logger.d(message);
  }

  /// **Info (`i`)** → Used for logging important but non-error information.
  /// Example: `AppLogger.i('User logged in successfully');`
  static void i(String message) {
    _logger.i(message);
  }

  /// **Warning (`w`)** → Used for logging warnings that are not critical errors but should be noticed.
  /// Example: `AppLogger.w('API response is slow, retrying...');`
  static void w(String message) {
    _logger.w(message);
  }

  /// **Error (`e`)** → Used to log runtime errors.
  /// Example: `AppLogger.e('Failed to fetch data', e, stacktrace);`
  static void e(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}

/// **Custom Log Printer** to provide a more informative log format.
class CustomLogPrinter extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    final emoji = _getEmoji(event.level);
    final callerInfo = _getCallerInfo();
    final message = event.message;

    // If the log level is Trace, display the stack trace if available
    if (event.level == Level.trace && event.error != null) {
      return ['[$emoji] $callerInfo - $message', 'StackTrace: ${event.error}'];
    }

    return ['[$emoji] $callerInfo - $message'];
  }

  /// Returns an emoji based on the log level
  String _getEmoji(Level level) {
    switch (level) {
      case Level.trace:
        return '🔍'; // Trace (Deep debugging)
      case Level.debug:
        return '🐛'; // Debugging
      case Level.info:
        return 'ℹ️'; // Information
      case Level.warning:
        return '⚠️'; // Warning
      case Level.error:
        return '❌'; // Error
      // case Level.wtf:
      //   return '🔥'; // Fatal error
      default:
        return '📌'; // Default
    }
  }

  /// Retrieves the class name and function that triggered the logger
  String _getCallerInfo() {
    try {
      // Retrieve the full stack trace as a string.
      final stackTrace = StackTrace.current.toString();

      // Split the stack trace into lines for better readability.
      final stackLines = stackTrace.split("\n");

      // For debugging, you can print the entire stack trace to help determine the correct line index.
      // Uncomment the following line to see the full stack trace.
      // print("Full Stack Trace: $stackTrace");

      // In this case, we are looking at the third line (index 2) for the calling function.
      // This may vary based on the specific stack trace format for your use case.
      final match = RegExp(r'(\w+)\.(\w+)\s+\(.*\)')
          .firstMatch(stackLines[5]); // Modify the index if necessary

      // Extract the class and function names from the match.
      if (match != null) {
        final className = match.group(1) ?? 'UnknownClass';
        final functionName = match.group(2) ?? 'UnknownFunction';
        return '[$className.$functionName]';
      }
    } catch (_) {}

    // If something goes wrong, return an unknown value.
    return '[Unknown]';
  }
}

// lib/core/utils/error_handler.dart
class ErrorHandler {
  static String getUserFriendlyErrorMessage(dynamic error) {
    // Log the actual error for debugging
    print('DEBUG - Original error: $error');

    final errorString = error.toString();

    if (errorString.contains('SocketException') ||
        errorString.contains('Connection failed') ||
        errorString.contains('Network is unreachable') ||
        errorString.contains('Failed host lookup') ||
        errorString.contains('No network connection available')) {
      return 'No Network\nPlease connect to an internet service';
    }

    if (errorString.contains('404') || errorString.contains('not found')) {
      return 'Data not found\nPlease try again later';
    }

    if (errorString.contains('timeout') || errorString.contains('timed out')) {
      return 'Request timeout\nPlease check your connection and try again';
    }

    if (errorString.contains('500') || errorString.contains('server error')) {
      return 'Server error\nWe\'re working on fixing this';
    }

    if (errorString.contains('FormatException') || errorString.contains('Bad response format')) {
      return 'Data format error\nPlease try again later';
    }

    // Default user-friendly message
    return 'Something went wrong\nPlease try again';
  }
}
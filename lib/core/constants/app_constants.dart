class AppConstants {
  static const String appName = 'Spy-da Music Retailer';
  static const String appVersion = '1.0.0';

  // Cache duration in seconds
  static const int cacheDuration = 3600;

  // App theme
  static const String primaryColorHex = '#000000';
  static const String accentColorHex = '#D4AF37';

  // API Timeout
  static const Duration apiTimeout = Duration(seconds: 30);

  // Validation patterns
  static const String emailPattern =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static const String phonePattern =
      r'^[\+]?[0-9\s\-\(\)]{10,}$';
}
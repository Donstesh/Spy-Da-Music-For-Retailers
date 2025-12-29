class ApiEndpoints {
  static const String baseUrl = 'https://spy-damusic.com';

  // JSON endpoints
  static String get settings => '$baseUrl/app/retail/settings.json';
  static String get label => '$baseUrl/app/retail/label.json';
  static String get artists => '$baseUrl/app/retail/artists.json';
  static String get distribution => '$baseUrl/app/retail/distribution.json';
  static String get contact => '$baseUrl/app/retail/contact.php';

  // Web pages
  static String get retailPlans => '$baseUrl/retail';
  static String get bookDemo => '$baseUrl/retail#demo';
  static String get subscribe => '$baseUrl/retail#subscribe';
}
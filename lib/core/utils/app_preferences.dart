import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static const String _firstLaunchKey = 'first_launch_complete';
  static const String _termsAcceptedKey = 'terms_accepted';

  /// Check if it's the first time the app is launched
  static Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    return !(prefs.getBool(_firstLaunchKey) ?? false);
  }

  /// Mark first launch as complete
  static Future<void> setFirstLaunchComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_firstLaunchKey, true);
  }

  /// Check if terms have been accepted
  static Future<bool> areTermsAccepted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_termsAcceptedKey) ?? false;
  }

  /// Mark terms as accepted
  static Future<void> setTermsAccepted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_termsAcceptedKey, true);
  }

  /// Reset all preferences (for testing)
  static Future<void> resetPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_firstLaunchKey);
    await prefs.remove(_termsAcceptedKey);
  }
}
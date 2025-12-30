import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static const String _firstLaunchKey = 'first_launch_complete';
  static const String _termsAcceptedKey = 'terms_accepted';

  // Cache for SharedPreferences instance
  static SharedPreferences? _prefs;

  // Get SharedPreferences instance
  static Future<SharedPreferences> _getInstance() async {
    if (_prefs != null) return _prefs!;
    _prefs = await SharedPreferences.getInstance();
    return _prefs!;
  }

  /// Check if it's the first time the app is launched
  static Future<bool> isFirstLaunch() async {
    try {
      final prefs = await _getInstance();
      return !(prefs.getBool(_firstLaunchKey) ?? false);
    } catch (e) {
      // If SharedPreferences fails, assume it's first launch
      print('Error checking first launch: $e');
      return true;
    }
  }

  /// Mark first launch as complete
  static Future<void> setFirstLaunchComplete() async {
    try {
      final prefs = await _getInstance();
      await prefs.setBool(_firstLaunchKey, true);
    } catch (e) {
      print('Error setting first launch: $e');
    }
  }

  /// Check if terms have been accepted
  static Future<bool> areTermsAccepted() async {
    try {
      final prefs = await _getInstance();
      return prefs.getBool(_termsAcceptedKey) ?? false;
    } catch (e) {
      // If SharedPreferences fails, assume terms not accepted
      print('Error checking terms: $e');
      return false;
    }
  }

  /// Mark terms as accepted
  static Future<void> setTermsAccepted() async {
    try {
      final prefs = await _getInstance();
      await prefs.setBool(_termsAcceptedKey, true);
    } catch (e) {
      print('Error setting terms: $e');
    }
  }

  /// Reset all preferences (for testing)
  static Future<void> resetPreferences() async {
    try {
      final prefs = await _getInstance();
      await prefs.remove(_firstLaunchKey);
      await prefs.remove(_termsAcceptedKey);
    } catch (e) {
      print('Error resetting preferences: $e');
    }
  }
}
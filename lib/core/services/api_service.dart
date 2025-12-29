import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_endpoints.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  Future<Map<String, dynamic>> fetchJson(
      String endpoint, {
        bool forceRefresh = false,
      }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cacheKey = 'cache_$endpoint';
      final timestampKey = 'timestamp_$endpoint';

      // Check cache if not forcing refresh
      if (!forceRefresh) {
        final cachedJson = prefs.getString(cacheKey);
        final cachedTimestamp = prefs.getInt(timestampKey);
        final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;

        if (cachedJson != null &&
            cachedTimestamp != null &&
            (now - cachedTimestamp) < 3600) {
          return json.decode(cachedJson);
        }
      }

      // Fetch from network
      final response = await http
          .get(Uri.parse(endpoint))
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        // Cache the response
        await prefs.setString(cacheKey, response.body);
        await prefs.setInt(
          timestampKey,
          DateTime.now().millisecondsSinceEpoch ~/ 1000,
        );

        return jsonData;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      // Try to return cached data on error
      final prefs = await SharedPreferences.getInstance();
      final cacheKey = 'cache_$endpoint';
      final cachedJson = prefs.getString(cacheKey);

      if (cachedJson != null) {
        return json.decode(cachedJson);
      }
      rethrow;
    }
  }

  Future<Map<String, dynamic>> postForm(
      String endpoint,
      Map<String, dynamic> data,
      ) async {
    try {
      final response = await http
          .post(
        Uri.parse(endpoint),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      )
          .timeout(const Duration(seconds: 30));

      return json.decode(response.body);
    } catch (e) {
      rethrow;
    }
  }
}
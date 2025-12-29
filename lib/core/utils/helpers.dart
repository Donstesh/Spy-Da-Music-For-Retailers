import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Helpers {
  static Future<bool> hasNetworkConnectivity() async {
    // You can use connectivity_plus package here
    // For now, return true assuming there's connectivity
    return true;
  }

  static String formatCurrency(double amount) {
    return '£${amount.toStringAsFixed(2)}';
  }

  static Future<void> saveToCache(String key, dynamic data) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = json.encode(data);
    await prefs.setString(key, jsonData);
    await prefs.setInt('${key}_timestamp', DateTime.now().millisecondsSinceEpoch);
  }

  static Future<dynamic> getFromCache(String key, Duration maxAge) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString(key);
    final timestamp = prefs.getInt('${key}_timestamp');

    if (jsonData == null || timestamp == null) {
      return null;
    }

    final cacheAge = DateTime.now().difference(
      DateTime.fromMillisecondsSinceEpoch(timestamp),
    );

    if (cacheAge > maxAge) {
      return null;
    }

    return json.decode(jsonData);
  }

  static void showSnackBar(BuildContext context, String message,
      {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    }
    return '${text.substring(0, maxLength)}...';
  }
}
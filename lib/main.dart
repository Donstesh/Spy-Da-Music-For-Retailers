import 'package:flutter/material.dart';
import 'app.dart';
import 'core/features/splash/splash_screen.dart';
import 'core/theme/app_theme.dart'; // Import your theme

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spy-da Music Retailer',
      theme: AppTheme.lightTheme, // Use your custom theme here
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/main': (context) => const MainApp(),
      },
    );
  }
}
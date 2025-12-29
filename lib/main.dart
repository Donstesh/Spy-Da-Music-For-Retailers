import 'package:flutter/material.dart';
import 'app.dart';
import 'core/features/onboarding/onboarding_screen.dart';
import 'core/features/onboarding/terms_screen.dart';
import 'core/features/splash/splash_screen.dart';
import 'core/utils/app_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spy-da Music Retailer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AppLoader(),
    );
  }
}

class AppLoader extends StatefulWidget {
  const AppLoader({super.key});

  @override
  State<AppLoader> createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader> {
  late Future<bool> _firstLaunchFuture;
  late Future<bool> _termsAcceptedFuture;

  @override
  void initState() {
    super.initState();
    _firstLaunchFuture = AppPreferences.isFirstLaunch();
    _termsAcceptedFuture = AppPreferences.areTermsAccepted();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([_firstLaunchFuture, _termsAcceptedFuture]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }

        if (snapshot.hasData) {
          final results = snapshot.data as List<bool>;
          final isFirstLaunch = results[0];
          final areTermsAccepted = results[1];

          if (isFirstLaunch) {
            return const OnboardingScreen();
          } else if (!areTermsAccepted) {
            return const TermsScreen();
          } else {
            return const MainApp();
          }
        }

        // If there's an error, show splash and retry
        return const SplashScreen();
      },
    );
  }
}
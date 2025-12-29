import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'core/features/artists/screens/artists_screen.dart';
import 'core/features/contact/screens/contact_screen.dart';
import 'core/features/distribution/distribution_screen.dart';
import 'core/features/label/screens/label_screen.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/custom_drawer.dart';
import 'core/widgets/custom_bottom_nav.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const LabelScreen(),
    const ArtistsScreen(),
    const DistributionScreen(),
    const ContactScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          title: 'Spy-da Music Retailer',
          theme: AppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          home: SafeArea(
            child: Scaffold(
              drawer: const CustomDrawer(),
              appBar: AppBar(
                title: const Text('Spy-da Music Retailer'),
              ),
              body: _screens[_currentIndex],
              bottomNavigationBar: CustomBottomNav(
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
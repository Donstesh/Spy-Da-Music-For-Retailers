import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          title: 'Spy-Da Music Retailer',
          theme: AppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            drawer: const CustomDrawer(),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: Container(
                color: Colors.black,
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                  left: 16.w,
                  right: 16.w,
                ),
                child: Row(
                  children: [
                    // Menu button
                    Builder(
                      builder: (context) => IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      ),
                    ),
                    // Spacer
                    const Spacer(),
                    // Logo/Image centered - USING splash.png
                    Image.asset(
                      'assets/images/splash.jpg',
                      height: 40.h,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 40.h,
                          child: const Center(
                            child: Text(
                              'Spy-da Music',
                              style: TextStyle(
                                color: Colors.amber,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    // Spacer to balance the menu button
                    const Spacer(),
                    // Search icon
                    IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // Add search functionality here
                        print('Search tapped');
                      },
                    ),
                  ],
                ),
              ),
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
        );
      },
    );
  }
}
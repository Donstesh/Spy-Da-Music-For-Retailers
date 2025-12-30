import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          title: 'Spy-Da Music Retailer',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const AppLoader(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

class AppLoader extends StatefulWidget {
  const AppLoader({super.key});

  @override
  State<AppLoader> createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader> {
  bool _isLoading = true;
  bool _goToMainApp = false;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Set a maximum loading time of 3 seconds
    await Future.delayed(const Duration(seconds: 3));

    // After timeout, go directly to main app
    if (mounted) {
      setState(() {
        _isLoading = false;
        _goToMainApp = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _buildSplashScreen();
    }

    return const MainApp();
  }

  Widget _buildSplashScreen() {
    return MaterialApp(
      home: Container(
        color: Colors.black,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.black,
                  child: Image.asset(
                    'assets/images/splash.png', // Try this path first
                    height: 150.h,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      // If splash.png doesn't exist, try splash.jpg
                      return Image.asset(
                        'assets/images/splash.jpg',
                        height: 150.h,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error2, stackTrace2) {
                          // If both images fail, show fallback
                          return Container(
                            height: 150.h,
                            color: Colors.black,
                            child: Icon(
                              Icons.music_note,
                              size: 100.w,
                              color: Colors.red,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.grey[800]!.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1.w,
                    ),
                  ),
                  child: Text(
                    'v1.0.0',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                CircularProgressIndicator(
                  color: Colors.grey[700],
                  strokeWidth: 2.w,
                ),
                SizedBox(height: 20.h),
                Text(
                  'Loading...',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
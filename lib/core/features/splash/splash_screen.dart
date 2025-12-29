import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Load necessary data
    await Future.wait([
      // You can add preloading of data here
      Future.delayed(const Duration(milliseconds: 500)),
    ]);

    // Navigate to main app
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/main');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Try to load icon_foreground, fallback to text
            _buildLogo(),
            SizedBox(height: 24.h),
            Text(
              'Spy-da Music',
              style: TextStyle(
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.accentColor,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'For Retailers',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 32.h),
            CircularProgressIndicator(
              color: AppColors.accentColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    try {
      return Image.asset(
        'assets/icons/icon_foreground.png',
        width: 150.w,
        height: 150.w,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return _buildFallbackLogo();
        },
      );
    } catch (e) {
      return _buildFallbackLogo();
    }
  }

  Widget _buildFallbackLogo() {
    return Container(
      width: 150.w,
      height: 150.w,
      decoration: BoxDecoration(
        color: AppColors.accentColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          Icons.music_note,
          size: 60.sp,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
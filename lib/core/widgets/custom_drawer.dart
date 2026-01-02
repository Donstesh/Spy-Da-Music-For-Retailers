import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';

class CustomDrawer extends StatelessWidget {
  final Function(int) onScreenSelected;

  const CustomDrawer({
    super.key,
    required this.onScreenSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 220.w,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer header
          Container(
            height: 120.h,
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                top: 25.h,
                left: 16.w,
                right: 16.w,
                bottom: 12.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  GestureDetector(
                    onTap: () => onScreenSelected(0), // Go to Home
                    child: Image.asset(
                      'assets/images/splash.jpg',
                      height: 55.h,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 40.h,
                          child: Center(
                            child: Text(
                              'Spy-da Music',
                              style: TextStyle(
                                color: Colors.amber,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'FOR RETAILERS',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.pureRed,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Menu items
          ListTile(
            leading: Icon(Icons.phone, size: 22.w),
            title: Text(
              'Contact Us',
              style: TextStyle(fontSize: 15.sp),
            ),
            onTap: () => onScreenSelected(2), // Contact Us screen
          ),
          ListTile(
            leading: Icon(Icons.library_music, size: 22.w),
            title: Text(
              'View Plans',
              style: TextStyle(fontSize: 15.sp),
            ),
            onTap: () => onScreenSelected(3), // View Plans screen
          ),
          ListTile(
            leading: Icon(Icons.schedule, size: 22.w),
            title: Text(
              'Book Demo',
              style: TextStyle(fontSize: 15.sp),
            ),
            onTap: () => onScreenSelected(1), // Contact screen
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.privacy_tip, size: 22.w),
            title: Text(
              'Privacy Policy',
              style: TextStyle(fontSize: 15.sp),
            ),
            onTap: () => onScreenSelected(4), // Privacy Policy screen
          ),
          ListTile(
            leading: Icon(Icons.description, size: 22.w),
            title: Text(
              'Terms of Service',
              style: TextStyle(fontSize: 15.sp),
            ),
            onTap: () => onScreenSelected(5), // Terms screen
          ),
        ],
      ),
    );
  }
}
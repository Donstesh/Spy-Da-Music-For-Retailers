import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/api_endpoints.dart';
import '../theme/app_colors.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 220.w,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer header with 20px offset from top
          Container(
            height: 120.h,
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                top: 25.h, // 20px offset from top
                left: 16.w,
                right: 16.w,
                bottom: 12.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo/Image from app bar
                  Image.asset(
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
                  SizedBox(height: 8.h),
                  // For Retailers text
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
            leading: Icon(Icons.info, size: 22.w),
            title: Text(
              'About Us',
              style: TextStyle(fontSize: 15.sp),
            ),
            onTap: () => _launchUrl('${ApiEndpoints.baseUrl}/about'),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
          ),
          ListTile(
            leading: Icon(Icons.phone, size: 22.w),
            title: Text(
              'Contact Sales',
              style: TextStyle(fontSize: 15.sp),
            ),
            onTap: () => _launchUrl('mailto:sales@spy-damusic.com'),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
          ),
          ListTile(
            leading: Icon(Icons.library_music, size: 22.w),
            title: Text(
              'View Plans',
              style: TextStyle(fontSize: 15.sp),
            ),
            onTap: () => _launchUrl(ApiEndpoints.retailPlans),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
          ),
          ListTile(
            leading: Icon(Icons.schedule, size: 22.w),
            title: Text(
              'Book Demo',
              style: TextStyle(fontSize: 15.sp),
            ),
            onTap: () => _launchUrl(ApiEndpoints.bookDemo),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.privacy_tip, size: 22.w),
            title: Text(
              'Privacy Policy',
              style: TextStyle(fontSize: 15.sp),
            ),
            onTap: () => _launchUrl('${ApiEndpoints.baseUrl}/privacy-policy'),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
          ),
          ListTile(
            leading: Icon(Icons.description, size: 22.w),
            title: Text(
              'Terms of Service',
              style: TextStyle(fontSize: 15.sp),
            ),
            onTap: () => _launchUrl('${ApiEndpoints.baseUrl}/terms'),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
          ),
        ],
      ),
    );
  }
}
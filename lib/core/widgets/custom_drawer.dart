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
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Spy-da Music',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'For Retailers',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.accentColor,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: Text(
              'About Us',
              style: TextStyle(fontSize: 16.sp),
            ),
            onTap: () => _launchUrl('${ApiEndpoints.baseUrl}/about'),
          ),
          ListTile(
            leading: const Icon(Icons.phone),
            title: Text(
              'Contact Sales',
              style: TextStyle(fontSize: 16.sp),
            ),
            onTap: () => _launchUrl('mailto:sales@spy-damusic.com'),
          ),
          ListTile(
            leading: const Icon(Icons.library_music),
            title: Text(
              'View Plans',
              style: TextStyle(fontSize: 16.sp),
            ),
            onTap: () => _launchUrl(ApiEndpoints.retailPlans),
          ),
          ListTile(
            leading: const Icon(Icons.schedule),
            title: Text(
              'Book Demo',
              style: TextStyle(fontSize: 16.sp),
            ),
            onTap: () => _launchUrl(ApiEndpoints.bookDemo),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: Text(
              'Privacy Policy',
              style: TextStyle(fontSize: 16.sp),
            ),
            onTap: () => _launchUrl('${ApiEndpoints.baseUrl}/privacy-policy'),
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: Text(
              'Terms of Service',
              style: TextStyle(fontSize: 16.sp),
            ),
            onTap: () => _launchUrl('${ApiEndpoints.baseUrl}/terms'),
          ),
        ],
      ),
    );
  }
}
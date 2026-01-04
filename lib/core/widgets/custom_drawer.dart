import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';

class CustomDrawer extends StatelessWidget {
  final Function(int) onScreenSelected;

  const CustomDrawer({
    super.key,
    required this.onScreenSelected,
  });

  // Function to make phone call
  Future<void> _makePhoneCall() async {
    const phoneNumber = '+442071014363';
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 220.w,
      backgroundColor: Colors.black,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: 189.h,
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: 30.h,
                  left: 16.w,
                  right: 16.w,
                  bottom: 16.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        onScreenSelected(0); // Home
                      },
                      child: Image.asset(
                        'assets/images/splash.jpg',
                        height: 70.h,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 50.h,
                            child: Center(
                              child: Text(
                                'Spy-da Music',
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'FOR ARTISTS & RETAILERS',
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: AppColors.pureRed,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Professional Music Solutions',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            // Empty space - center the call us button
            Expanded(
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Call Us button
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _makePhoneCall();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.pureRed,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                            vertical: 14.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          elevation: 4,
                        ),
                        icon: Icon(
                          Icons.phone,
                          size: 20.w,
                        ),
                        label: Text(
                          'Call Us Now',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        '+44 (0) 207 101 4363',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'Available 24/7',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white70,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Footer
            Container(
              color: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '© ${DateTime.now().year} Spy-da Recordings',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 13.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'All rights reserved',
                    style: TextStyle(
                      color: Colors.white30,
                      fontSize: 11.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
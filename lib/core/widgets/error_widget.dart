// lib/core/widgets/error_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback? onRetry;

  const CustomErrorWidget({
    super.key,
    required this.errorMessage,
    this.onRetry,
  });

  String _getUserFriendlyErrorMessage(dynamic error) {
    // Log the actual error for debugging
    print('DEBUG - Original error: $error');

    final errorString = error.toString();

    // Check for DNS/host resolution errors first
    if (errorString.contains('Failed host lookup') ||
        errorString.contains('No address associated with hostname') ||
        errorString.contains('spy-damusic.com')) {
      return 'Server temporarily unavailable\nPlease try again in a few moments';
    }

    // Check for actual network connection errors
    if (errorString.contains('SocketException') &&
        !errorString.contains('Failed host lookup')) {
      return 'No internet connection\nPlease check your network and try again';
    }

    if (errorString.contains('Connection failed') ||
        errorString.contains('Network is unreachable')) {
      return 'No internet connection\nPlease check your network and try again';
    }

    // Check for server-specific errors
    if (errorString.contains('404') || errorString.contains('not found')) {
      return 'Data not found\nPlease try again later';
    }

    if (errorString.contains('timeout') || errorString.contains('timed out')) {
      return 'Request timeout\nServer is taking too long to respond';
    }

    if (errorString.contains('500') || errorString.contains('server error')) {
      return 'Server error\nWe\'re working on fixing this';
    }

    if (errorString.contains('FormatException') || errorString.contains('Bad response format')) {
      return 'Please Refresh Page\nor\nCheck Your Internet Connection';
    }

    // Default user-friendly message
    return 'Temporary service issue\nPlease try again in a few moments';
  }

  @override
  Widget build(BuildContext context) {
    final userFriendlyMessage = _getUserFriendlyErrorMessage(errorMessage);
    final isNetworkError = errorMessage.contains('SocketException') &&
        !errorMessage.contains('Failed host lookup');
    final isDNSError = errorMessage.contains('Failed host lookup') ||
        errorMessage.contains('No address associated with hostname');

    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isNetworkError
                  ? Icons.wifi_off
                  : isDNSError
                  ? Icons.cloud_off
                  : Icons.error_outline,
              color: isNetworkError
                  ? AppColors.textSecondary
                  : isDNSError
                  ? AppColors.warningColor
                  : AppColors.errorColor,
              size: 48.sp,
            ),
            SizedBox(height: 16.h),
            Text(
              isNetworkError
                  ? 'No Internet'
                  : isDNSError
                  ? 'Server Unavailable'
                  : 'Oops! Something went wrong',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                userFriendlyMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
            ),
            SizedBox(height: 24.h),
            if (onRetry != null)
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentColor,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 32.w,
                    vertical: 12.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  'Try Again',
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
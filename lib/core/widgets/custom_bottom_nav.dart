import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    return Container(
      height: isLandscape ? 55.h : 60.h,
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.business, 'Label', 0, isLandscape),
          _buildNavItem(Icons.music_note, 'Artists', 1, isLandscape),
          _buildNavItem(Icons.store, 'Distribution', 2, isLandscape),
          _buildNavItem(Icons.contact_mail, 'Contact', 3, isLandscape),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index, bool isLandscape) {
    final isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        constraints: BoxConstraints(
          minHeight: 45.h,
          maxHeight: 50.h,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: isLandscape ? 8.w : 10.w,
          vertical: isLandscape ? 4.h : 6.h,
        ),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          border: isSelected
              ? Border.all(
            color: Colors.red.withOpacity(0.5), // Increased from 0.3 to 0.5
            width: 1.w,
          )
              : null,
        ),
        child: SizedBox(
          width: isLandscape ? 60.w : 65.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: isLandscape ? 14.sp : 16.sp,
                color: isSelected ? Colors.red : Colors.red.withOpacity(0.9), // Increased from 0.6 to 0.9
              ),
              SizedBox(height: 2.h),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? Colors.red : Colors.red.withOpacity(0.9), // Increased from 0.6 to 0.9
                    fontSize: isLandscape ? 7.sp : 8.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
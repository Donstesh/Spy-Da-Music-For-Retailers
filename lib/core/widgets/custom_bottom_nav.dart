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
      height: isLandscape ? 40.h : 48.h, // Further reduced: 45/55 → 40/48
      color: Colors.black,
      child: Row(
        children: [
          _buildNavItem(Icons.home, 'Home', 0, isLandscape),
          _buildNavItem(Icons.library_music, 'Plans', 1, isLandscape),
          _buildNavItem(Icons.privacy_tip, 'Privacy', 2, isLandscape),
          _buildNavItem(Icons.description, 'Terms', 3, isLandscape),
          _buildNavItem(Icons.contact_mail, 'Contact', 4, isLandscape),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index, bool isLandscape) {
    final isSelected = currentIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: Container(
          height: isLandscape ? 40.h : 48.h, // Further reduced: 45/55 → 40/48
          padding: EdgeInsets.symmetric(vertical: isLandscape ? 1.h : 2.h), // Reduced more
          decoration: BoxDecoration(
            color: isSelected ? Colors.red.withOpacity(0.12) : Colors.transparent,
            borderRadius: BorderRadius.circular(4.r), // Reduced from 6
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: isLandscape ? 12.sp : 16.sp, // Reduced from 14/18 to 12/16
                color: isSelected ? Colors.red : Colors.red.withOpacity(0.9),
              ),
              SizedBox(height: isLandscape ? 0.3.h : 0.6.h), // Reduced spacing
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.red : Colors.red.withOpacity(0.9),
                  fontSize: isLandscape ? 6.sp : 8.sp, // Reduced from 7/9 to 6/8
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  height: 1.0, // Reduced line height
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
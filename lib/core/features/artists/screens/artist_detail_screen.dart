import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../models/artist_model.dart';

class ArtistDetailScreen extends StatelessWidget {
  final Artist artist;

  const ArtistDetailScreen({
    super.key,
    required this.artist,
  });

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(artist.name),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Artist Image
            Center(
              child: Container(
                width: 200.w,
                height: 200.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: CachedNetworkImage(
                    imageUrl: artist.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                        color: AppColors.accentColor,
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: AppColors.backgroundColor,
                      child: const Icon(Icons.person, size: 60),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // Bio
            Text(
              'About',
              style: AppTextStyles.titleLarge.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              artist.bioShort,
              style: AppTextStyles.bodyLarge,
            ),
            SizedBox(height: 24.h),

            // Genres & Moods
            Row(
              children: [
                Expanded(
                  child: _buildInfoSection(
                    title: 'Genres',
                    items: artist.genres,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _buildInfoSection(
                    title: 'Moods',
                    items: artist.moods,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // Best For
            Text(
              'Best For',
              style: AppTextStyles.titleLarge.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 8.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: artist.bestFor
                  .map((bestFor) => Chip(
                label: Text(bestFor),
                backgroundColor: AppColors.accentColor.withOpacity(0.1),
                labelStyle: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.accentColor,
                ),
              ))
                  .toList(),
            ),
            SizedBox(height: 24.h),

            // Clean Music Promise
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.successColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: AppColors.successColor.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.verified,
                    color: AppColors.successColor,
                    size: 24.sp,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Clean Music Promise',
                          style: AppTextStyles.titleMedium.copyWith(
                            color: AppColors.successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'All tracks are curated to be brand-safe with no explicit content',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.successColor.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Preview Links
            Text(
              'Listen Now',
              style: AppTextStyles.titleLarge.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 12.h),
            Column(
              children: artist.previewLinks
                  .map(
                    (link) => Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _launchUrl(link.url),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                      ),
                      child: Text(link.label),
                    ),
                  ),
                ),
              )
                  .toList(),
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection({
    required String title,
    required List<String> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.titleMedium.copyWith(
            color: AppColors.primaryColor,
          ),
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 4.w,
          children: items
              .map(
                (item) => Chip(
              label: Text(item),
              backgroundColor: AppColors.primaryColor.withOpacity(0.1),
              labelStyle: AppTextStyles.bodySmall.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          )
              .toList(),
        ),
      ],
    );
  }
}
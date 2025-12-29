import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/content_page.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../models/label_model.dart';

class LabelScreen extends StatefulWidget {
  const LabelScreen({super.key});

  @override
  State<LabelScreen> createState() => _LabelScreenState();
}

class _LabelScreenState extends State<LabelScreen> {
  late Future<LabelData> _labelDataFuture;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadLabelData();
  }

  Future<void> _loadLabelData() async {
    _labelDataFuture = _fetchLabelData();
  }

  Future<LabelData> _fetchLabelData() async {
    final apiService = ApiService();
    final jsonData = await apiService.fetchJson(ApiEndpoints.label);
    return LabelData.fromJson(jsonData);
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      // You can add search functionality here
      print('Search query: $query');
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LabelData>(
      future: _labelDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ContentPage(
            title: 'Spy-da Music',
            child: Container(), // Empty while loading
            isLoading: true,
          );
        }

        if (snapshot.hasError) {
          return ContentPage(
            title: 'Spy-da Music',
            child: Container(), // Empty for error
            hasError: true,
            errorMessage: snapshot.error.toString(),
            onRetry: _loadLabelData,
          );
        }

        if (snapshot.hasData) {
          final data = snapshot.data!;
          return _buildContent(data);
        }

        return ContentPage(
          title: 'Spy-da Music',
          child: Container(), // Empty for no data
          hasError: true,
          errorMessage: 'No data available',
          onRetry: _loadLabelData,
        );
      },
    );
  }

  Widget _buildContent(LabelData data) {
    return ContentPage(
      title: 'Spy-da Music',
      showSearch: false, // Set to true if you want search
      onSearchChanged: _onSearchChanged,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero Section
          _buildHeroSection(data.hero),
          SizedBox(height: 24.h),

          // Sections
          for (var section in data.sections) ...[
            _buildSection(section),
            SizedBox(height: 24.h),
          ],

          // Link Cards
          _buildLinkCards(data.linkCards),
          SizedBox(height: 16.h),

          // Footer Note
          Text(
            data.footerNote,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  Widget _buildHeroSection(HeroSection hero) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              hero.title,
              style: AppTextStyles.headlineMedium.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              hero.subtitle,
              style: AppTextStyles.bodyMedium,
            ),
            SizedBox(height: 16.h),
            Column(
              children: hero.ctaButtons.map((cta) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _launchUrl(cta.url),
                      child: Text(cta.label),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(LabelSection section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          section.title,
          style: AppTextStyles.titleLarge.copyWith(
            color: AppColors.primaryColor,
          ),
        ),
        SizedBox(height: 12.h),

        if (section.bullets != null)
          ...section.bullets!.map((bullet) {
            return Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 4.h, right: 8.w),
                    child: Icon(
                      Icons.check_circle,
                      color: AppColors.accentColor,
                      size: 16.sp,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      bullet,
                      style: AppTextStyles.bodyMedium,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),

        if (section.cards != null)
          SizedBox(height: 16.h),
        if (section.cards != null)
          ...section.cards!.map((card) {
            return _buildPlanCard(card);
          }).toList(),
      ],
    );
  }

  Widget _buildPlanCard(PlanCard card) {
    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  card.name,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                Text(
                  card.priceText,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: card.points.map((point) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: Text(
                    '• $point',
                    style: AppTextStyles.bodyMedium,
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => _launchUrl(card.cta.url),
                child: Text(card.cta.label),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLinkCards(List<LinkCard> cards) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Useful Links',
          style: AppTextStyles.titleLarge.copyWith(
            color: AppColors.primaryColor,
          ),
        ),
        SizedBox(height: 12.h),
        ...cards.map((card) {
          return Card(
            margin: EdgeInsets.only(bottom: 12.h),
            child: ListTile(
              title: Text(card.title),
              subtitle: Text(card.subtitle),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () => _launchUrl(card.url),
            ),
          );
        }).toList(),
      ],
    );
  }
}
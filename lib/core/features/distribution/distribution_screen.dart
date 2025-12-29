import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/constants/api_endpoints.dart';

class DistributionScreen extends StatefulWidget {
  const DistributionScreen({super.key});

  @override
  State<DistributionScreen> createState() => _DistributionScreenState();
}

class _DistributionScreenState extends State<DistributionScreen> {
  late Future<Map<String, dynamic>> _distributionDataFuture;
  final List<bool> _faqExpansionStates = [];

  @override
  void initState() {
    super.initState();
    _loadDistributionData();
  }

  Future<void> _loadDistributionData() async {
    _distributionDataFuture = _fetchDistributionData();
  }

  Future<Map<String, dynamic>> _fetchDistributionData() async {
    final apiService = ApiService();
    return await apiService.fetchJson(ApiEndpoints.distribution);
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _distributionDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget();
        }

        if (snapshot.hasError) {
          return CustomErrorWidget(
            errorMessage: snapshot.error.toString(),
            onRetry: _loadDistributionData,
          );
        }

        if (snapshot.hasData) {
          final data = snapshot.data!;
          // Initialize FAQ expansion states
          if (_faqExpansionStates.isEmpty) {
            final faqList = data['faq'] as List? ?? [];
            _faqExpansionStates.addAll(List.filled(faqList.length, false));
          }
          return _buildScreenContent(data);
        }

        return const CustomErrorWidget(errorMessage: 'No data available');
      },
    );
  }

  Widget _buildScreenContent(Map<String, dynamic> data) {
    final hero = data['hero'] as Map<String, dynamic>;
    final howItWorks = data['how_it_works'] as List;
    final benefits = data['benefits'] as List;
    final plans = data['plans'] as List;
    final faq = data['faq'] as List;
    final ctas = data['ctas'] as List;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero Section
          _buildHeroSection(hero),
          SizedBox(height: 32.h),

          // How It Works
          Text(
            'How It Works',
            style: AppTextStyles.headlineMedium.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 16.h),
          _buildHowItWorks(howItWorks),
          SizedBox(height: 32.h),

          // Benefits
          Text(
            'Benefits',
            style: AppTextStyles.headlineMedium.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 16.h),
          _buildBenefits(benefits),
          SizedBox(height: 32.h),

          // Plans
          Text(
            'Subscription Plans',
            style: AppTextStyles.headlineMedium.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 16.h),
          _buildPlans(plans),
          SizedBox(height: 32.h),

          // FAQ
          Text(
            'Frequently Asked Questions',
            style: AppTextStyles.headlineMedium.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 16.h),
          _buildFAQ(faq),
          SizedBox(height: 32.h),

          // CTA Buttons
          _buildCTAs(ctas),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  Widget _buildHeroSection(Map<String, dynamic> hero) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      color: AppColors.primaryColor,
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              hero['title'],
              style: AppTextStyles.headlineMedium.copyWith(
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              hero['subtitle'],
              style: AppTextStyles.bodyLarge.copyWith(
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHowItWorks(List howItWorks) {
    return Column(
      children: howItWorks.asMap().entries.map((entry) {
        final index = entry.key;
        final step = entry.value as Map<String, dynamic>;
        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: AppColors.accentColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${step['step']}',
                        style: AppTextStyles.titleLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step['title'],
                          style: AppTextStyles.titleMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          step['text'],
                          style: AppTextStyles.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBenefits(List benefits) {
    return Column(
      children: benefits
          .map(
            (benefit) => Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 4.h, right: 12.w),
                child: Icon(
                  Icons.check_circle,
                  color: AppColors.successColor,
                  size: 20.sp,
                ),
              ),
              Expanded(
                child: Text(
                  benefit,
                  style: AppTextStyles.bodyLarge,
                ),
              ),
            ],
          ),
        ),
      )
          .toList(),
    );
  }

  Widget _buildPlans(List plans) {
    return Column(
      children: plans.map((plan) {
        final p = plan as Map<String, dynamic>;
        return Card(
          margin: EdgeInsets.only(bottom: 16.h),
          elevation: 2,
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      p['name'],
                      style: AppTextStyles.titleLarge.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      p['price_text'],
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.accentColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: (p['includes'] as List)
                      .map(
                        (include) => Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check,
                            color: AppColors.successColor,
                            size: 16.sp,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              include,
                              style: AppTextStyles.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                      .toList(),
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _launchUrl(p['cta_url']),
                    child: const Text('View Details'),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFAQ(List faq) {
    return Column(
      children: faq.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value as Map<String, dynamic>;
        return Card(
          margin: EdgeInsets.only(bottom: 8.h),
          child: ExpansionTile(
            title: Text(
              item['q'],
              style: AppTextStyles.titleMedium.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            children: [
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Text(
                  item['a'],
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
            onExpansionChanged: (expanded) {
              setState(() {
                _faqExpansionStates[index] = expanded;
              });
            },
            trailing: Icon(
              _faqExpansionStates[index]
                  ? Icons.expand_less
                  : Icons.expand_more,
              color: AppColors.primaryColor,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCTAs(List ctas) {
    return Column(
      children: ctas
          .map(
            (cta) => Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _launchUrl(cta['url']),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.h),
              ),
              child: Text(
                cta['label'],
                style: AppTextStyles.button,
              ),
            ),
          ),
        ),
      )
          .toList(),
    );
  }
}
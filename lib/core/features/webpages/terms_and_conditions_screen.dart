import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  State<TermsAndConditionsScreen> createState() => _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  final List<Map<String, dynamic>> _sections = [
    {
      'title': 'Retailer Agreement',
      'content':
      'This Retailer Agreement ("Agreement") governs your use of Spy-Da Recordings retail music services. By subscribing to our services, you agree to be bound by these terms.',
      'icon': Icons.handshake,
    },
    {
      'title': 'Service Description',
      'content':
      'Spy-Da Recordings provides background music services for retail establishments including curated playlists, commercial licensing, and regular updates based on your subscription tier.',
      'icon': Icons.music_note,
    },
    {
      'title': 'Subscription Plans',
      'content':
      'We offer three subscription tiers: Retail-Basic (£149.99/year), Retail-Premium (£179.99/year), and Retail-Elite (£199.99/year). Each tier offers different features as described on our pricing page.',
      'icon': Icons.subscriptions,
    },
    {
      'title': 'Payment Terms',
      'content':
      'All subscriptions are billed annually. Payment is due upfront. Prices are in GBP and inclusive of applicable taxes. No refunds are provided for partial subscription periods.',
      'icon': Icons.payment,
    },
    {
      'title': 'Commercial License',
      'content':
      'Your subscription includes a commercial license to play the provided music in your retail establishment. This license is non-transferable and limited to the subscribed business location.',
      'icon': Icons.copyright,
    },
    {
      'title': 'Usage Restrictions',
      'content':
      'You may not record, copy, distribute, or resell the music provided. The service is for background music only in your retail space. Public performance beyond your premises is prohibited.',
      'icon': Icons.block,
    },
    {
      'title': 'Account Security',
      'content':
      'You are responsible for maintaining the confidentiality of your account credentials. You must notify us immediately of any unauthorized use of your account.',
      'icon': Icons.security,
    },
    {
      'title': 'Service Availability',
      'content':
      'We strive for 99.9% uptime but do not guarantee uninterrupted service. We may perform maintenance that temporarily affects availability. We will provide notice for scheduled maintenance when possible.',
      'icon': Icons.cloud,
    },
    {
      'title': 'Content Updates',
      'content':
      'Playlists are updated according to your subscription tier: Basic (monthly), Premium (bi-weekly), Elite (weekly). We reserve the right to modify or remove content from playlists.',
      'icon': Icons.update,
    },
    {
      'title': 'Termination',
      'content':
      'You may cancel your subscription at any time, but no refunds will be provided. We may terminate your account for violation of these terms. Upon termination, all music rights immediately cease.',
      'icon': Icons.cancel,
    },
    {
      'title': 'Liability Limitations',
      'content':
      'Spy-Da Recordings shall not be liable for any indirect, incidental, or consequential damages. Our total liability shall not exceed the amount paid for your subscription in the last 12 months.',
      'icon': Icons.warning,
    },
    {
      'title': 'Governing Law',
      'content':
      'This Agreement is governed by the laws of England and Wales. Any disputes shall be subject to the exclusive jurisdiction of the courts of England and Wales.',
      'icon': Icons.balance,
    },
  ];

  final List<Map<String, dynamic>> _importantPoints = [
    {
      'title': 'License Coverage',
      'points': [
        'Coverage for one retail location',
        'Unlimited play during business hours',
        'Background music use only',
        'No broadcasting or recording rights',
        'License valid for subscription period'
      ],
    },
    {
      'title': 'Technical Requirements',
      'points': [
        'Stable internet connection required',
        'Compatible audio system needed',
        'Recommended 5 Mbps bandwidth',
        'Support for streaming audio',
        'Regular updates recommended'
      ],
    },
    {
      'title': 'Subscription Features',
      'points': [
        'Automated playlist updates',
        'No manual downloads required',
        'Access via web player or app',
        'Volume normalization',
        'Genre-based playlists'
      ],
    },
  ];

  final List<Map<String, dynamic>> _faqItems = [
    {
      'question': 'Can I use the music in multiple locations?',
      'answer': 'Each subscription covers one retail location. Contact us for multi-location pricing.'
    },
    {
      'question': 'What happens if I cancel my subscription?',
      'answer': 'Access to playlists ends immediately. No refunds for unused subscription time.'
    },
    {
      'question': 'Can I request specific songs?',
      'answer': 'Elite tier includes priority song requests. Basic and Premium tiers use curated playlists only.'
    },
    {
      'question': 'Is offline playback available?',
      'answer': 'Currently, all playback requires an active internet connection. Offline features are in development.'
    },
    {
      'question': 'How do playlist updates work?',
      'answer': 'New playlists automatically appear in your account according to your subscription tier schedule.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // App Bar - Removed back button and print button
                SliverAppBar(
                  backgroundColor: Colors.black,
                  expandedHeight: constraints.maxWidth > 600 ? 100.h : 80.h,
                  floating: true,
                  pinned: true,
                  automaticallyImplyLeading: false, // Remove back button
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    titlePadding: EdgeInsets.only(bottom: 8.h),
                    title: Text(
                      'Terms & Conditions',
                      style: AppTextStyles.titleLarge.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: constraints.maxWidth > 600 ? 20.sp : 16.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    background: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Header Section
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth > 600 ? 24.w : 16.w,
                      vertical: 20.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(constraints.maxWidth > 600 ? 20.r : 16.r),
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: AppColors.pureRed.withOpacity(0.3),
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.store,
                                size: constraints.maxWidth > 600 ? 44.sp : 36.sp,
                                color: AppColors.pureRed,
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                'Retailer Terms of Service',
                                style: AppTextStyles.headlineLarge.copyWith(
                                  color: Colors.white,
                                  fontSize: constraints.maxWidth > 600 ? 22.sp : 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                'For Retail Music Subscription Services',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: Colors.white70,
                                  fontSize: constraints.maxWidth > 600 ? 14.sp : 12.sp,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    size: constraints.maxWidth > 600 ? 16.sp : 14.sp,
                                    color: AppColors.pureRed,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    'Effective: January 2024',
                                    style: AppTextStyles.caption.copyWith(
                                      color: AppColors.pureRed,
                                      fontSize: constraints.maxWidth > 600 ? 12.sp : 11.sp,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          'This agreement applies specifically to retail businesses subscribing to Spy-Da Recordings background music services.',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Colors.white70,
                            fontSize: constraints.maxWidth > 600 ? 14.sp : 12.sp,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),

                // Important Points
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth > 600 ? 24.w : 16.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Key License Information',
                          style: AppTextStyles.titleLarge.copyWith(
                            color: Colors.white,
                            fontSize: constraints.maxWidth > 600 ? 20.sp : 18.sp,
                          ),
                        ),
                        SizedBox(height: 12.h),
                      ],
                    ),
                  ),
                ),

                // Important Points List
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth > 600 ? 24.w : 16.w,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        final point = _importantPoints[index];
                        return Container(
                          margin: EdgeInsets.only(
                            bottom: constraints.maxWidth > 600 ? 12.h : 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              dividerColor: Colors.transparent,
                            ),
                            child: ExpansionTile(
                              tilePadding: EdgeInsets.symmetric(
                                horizontal: constraints.maxWidth > 600 ? 16.w : 12.w,
                                vertical: constraints.maxWidth > 600 ? 12.h : 8.h,
                              ),
                              iconColor: AppColors.pureRed,
                              collapsedIconColor: AppColors.pureRed,
                              title: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: constraints.maxWidth > 600 ? 40.h : 32.h,
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    point['title'],
                                    style: AppTextStyles.titleMedium.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: constraints.maxWidth > 600 ? 14.sp : 12.sp,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: constraints.maxWidth > 600 ? 16.w : 12.w,
                                    right: constraints.maxWidth > 600 ? 16.w : 12.w,
                                    bottom: constraints.maxWidth > 600 ? 16.h : 12.h,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: (point['points'] as List<String>)
                                        .map((item) => Padding(
                                      padding: EdgeInsets.only(bottom: 8.h),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 4.h),
                                            child: Icon(
                                              Icons.check_circle,
                                              size: constraints.maxWidth > 600 ? 16.sp : 14.sp,
                                              color: AppColors.pureRed,
                                            ),
                                          ),
                                          SizedBox(width: 12.w),
                                          Expanded(
                                            child: Text(
                                              item,
                                              style: AppTextStyles.bodyMedium
                                                  .copyWith(
                                                color: Colors.white70,
                                                fontSize: constraints.maxWidth > 600 ? 12.sp : 11.sp,
                                              ),
                                              maxLines: 2,
                                              overflow:
                                              TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: _importantPoints.length,
                    ),
                  ),
                ),

                // FAQ Section
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.all(constraints.maxWidth > 600 ? 16.r : 12.r),
                    padding: EdgeInsets.all(constraints.maxWidth > 600 ? 20.r : 16.r),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.help,
                              color: AppColors.pureRed,
                              size: constraints.maxWidth > 600 ? 24.sp : 20.sp,
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              'Frequently Asked Questions',
                              style: AppTextStyles.titleLarge.copyWith(
                                color: Colors.white,
                                fontSize: constraints.maxWidth > 600 ? 20.sp : 18.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Column(
                          children: _faqItems.map((faq) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                dividerColor: Colors.transparent,
                              ),
                              child: Container(
                                margin: EdgeInsets.only(bottom: 8.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: ExpansionTile(
                                  tilePadding: EdgeInsets.symmetric(
                                    horizontal: 0,
                                    vertical: constraints.maxWidth > 600 ? 12.h : 8.h,
                                  ),
                                  iconColor: AppColors.pureRed,
                                  collapsedIconColor: AppColors.pureRed,
                                  title: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minHeight: constraints.maxWidth > 600 ? 40.h : 32.h,
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        faq['question'],
                                        style: AppTextStyles.bodyLarge.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: constraints.maxWidth > 600 ? 14.sp : 12.sp,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 0,
                                        right: 0,
                                        bottom: constraints.maxWidth > 600 ? 16.h : 12.h,
                                      ),
                                      child: Text(
                                        faq['answer'],
                                        style: AppTextStyles.bodyMedium.copyWith(
                                          color: Colors.white70,
                                          fontSize: constraints.maxWidth > 600 ? 12.sp : 11.sp,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),

                // Full Terms Sections
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      constraints.maxWidth > 600 ? 24.w : 16.w,
                      constraints.maxWidth > 600 ? 24.h : 20.h,
                      constraints.maxWidth > 600 ? 24.w : 16.w,
                      0,
                    ),
                    child: Text(
                      'Complete Terms & Conditions',
                      style: AppTextStyles.titleLarge.copyWith(
                        color: Colors.white,
                        fontSize: constraints.maxWidth > 600 ? 20.sp : 18.sp,
                      ),
                    ),
                  ),
                ),

                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final section = _sections[index];
                      return Container(
                        margin: EdgeInsets.fromLTRB(
                          constraints.maxWidth > 600 ? 24.w : 16.w,
                          constraints.maxWidth > 600 ? 12.h : 8.h,
                          constraints.maxWidth > 600 ? 24.w : 16.w,
                          index == _sections.length - 1 ? 16.h : 0,
                        ),
                        padding: EdgeInsets.all(constraints.maxWidth > 600 ? 16.r : 12.r),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(constraints.maxWidth > 600 ? 10.r : 8.r),
                              decoration: BoxDecoration(
                                color: AppColors.pureRed.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Icon(
                                section['icon'],
                                size: constraints.maxWidth > 600 ? 20.sp : 18.sp,
                                color: AppColors.pureRed,
                              ),
                            ),
                            SizedBox(width: constraints.maxWidth > 600 ? 16.w : 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${index + 1}. ${section['title']}',
                                    style: AppTextStyles.titleMedium.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: constraints.maxWidth > 600 ? 14.sp : 12.sp,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(
                                    section['content'],
                                    style: AppTextStyles.bodyMedium.copyWith(
                                      color: Colors.white70,
                                      fontSize: constraints.maxWidth > 600 ? 12.sp : 11.sp,
                                    ),
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: _sections.length,
                  ),
                ),

                // Subscription Tiers Summary
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.all(constraints.maxWidth > 600 ? 16.r : 12.r),
                    padding: EdgeInsets.all(constraints.maxWidth > 600 ? 20.r : 16.r),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.pureRed.withOpacity(0.2),
                          Colors.grey[900]!,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: AppColors.pureRed.withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Subscription Tiers Overview',
                          style: AppTextStyles.titleLarge.copyWith(
                            color: Colors.white,
                            fontSize: constraints.maxWidth > 600 ? 20.sp : 18.sp,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Container(
                          width: double.infinity,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columnSpacing: 20.w,
                              dataRowMinHeight: 40.h,
                              headingTextStyle: AppTextStyles.titleMedium.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: constraints.maxWidth > 600 ? 14.sp : 12.sp,
                              ),
                              dataTextStyle: AppTextStyles.bodyMedium.copyWith(
                                color: Colors.white70,
                                fontSize: constraints.maxWidth > 600 ? 12.sp : 11.sp,
                              ),
                              columns: [
                                DataColumn(label: Text('Feature')),
                                DataColumn(label: Text('Basic')),
                                DataColumn(label: Text('Premium')),
                                DataColumn(label: Text('Elite')),
                              ],
                              rows: [
                                DataRow(cells: [
                                  DataCell(Text('Price/Year')),
                                  DataCell(Text('£149.99')),
                                  DataCell(Text('£179.99')),
                                  DataCell(Text('£199.99')),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('Updates')),
                                  DataCell(Text('Monthly')),
                                  DataCell(Text('Bi-weekly')),
                                  DataCell(Text('Weekly')),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('Support')),
                                  DataCell(Text('Standard')),
                                  DataCell(Text('Enhanced')),
                                  DataCell(Text('Priority')),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('License')),
                                  DataCell(Text('Single Location')),
                                  DataCell(Text('Single Location')),
                                  DataCell(Text('Single Location')),
                                ]),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          'All tiers include commercial licensing for one retail location and automated playlist delivery.',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontSize: constraints.maxWidth > 600 ? 14.sp : 12.sp,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),

                // Support Contact Section
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.all(constraints.maxWidth > 600 ? 16.r : 12.r),
                    padding: EdgeInsets.all(constraints.maxWidth > 600 ? 20.r : 16.r),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Support Contact',
                          style: AppTextStyles.titleMedium.copyWith(
                            color: Colors.white,
                            fontSize: constraints.maxWidth > 600 ? 18.sp : 16.sp,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          'For questions about our services or technical support:',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Colors.white70,
                            fontSize: constraints.maxWidth > 600 ? 14.sp : 12.sp,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 16.h),
                        _buildContactItem(
                          Icons.email,
                          'info@spy-damusic.com',
                          constraints,
                        ),
                        _buildContactItem(
                          Icons.phone,
                          '+44 (0) 207 101 4363',
                          constraints,
                        ),
                        _buildContactItem(
                          Icons.access_time,
                          'Mon-Fri, 9AM-5PM GMT',
                          constraints,
                        ),
                        SizedBox(height: 16.h),
                        Divider(color: Colors.white30),
                        SizedBox(height: 16.h),
                        Text(
                          'We aim to respond to all inquiries within 24 business hours.',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: Colors.white70,
                            fontSize: constraints.maxWidth > 600 ? 12.sp : 11.sp,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),

                // Add some bottom padding
                SliverToBoxAdapter(
                  child: SizedBox(height: 40.h),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text, BoxConstraints constraints) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: constraints.maxWidth > 600 ? 20.sp : 18.sp,
            color: AppColors.pureRed,
          ),
          SizedBox(width: constraints.maxWidth > 600 ? 12.w : 8.w),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.white,
                fontSize: constraints.maxWidth > 600 ? 14.sp : 12.sp,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  void _printTerms() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Preparing terms for printing...'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
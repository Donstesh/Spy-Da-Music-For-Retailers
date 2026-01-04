import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  final List<Map<String, dynamic>> _sections = [
    {
      'title': 'Introduction',
      'content':
      'Spy-Da Recordings is committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our services.',
      'icon': Icons.security,
    },
    {
      'title': 'Information We Collect',
      'content':
      'We collect personal information that you provide directly to us, including name, email address, phone number, payment information, and music content. We also automatically collect usage data through cookies and analytics.',
      'icon': Icons.collections_bookmark,
    },
    {
      'title': 'How We Use Your Information',
      'content':
      'We use your information to provide and improve our services, process payments, communicate with you, send marketing materials (with your consent), comply with legal obligations, and protect our rights and property.',
      'icon': Icons.data_usage,
    },
    {
      'title': 'Information Sharing',
      'content':
      'We may share your information with service providers who assist in our operations, with music platforms for distribution, with payment processors, and when required by law. We do not sell your personal information.',
      'icon': Icons.share,
    },
    {
      'title': 'Data Security',
      'content':
      'We implement appropriate technical and organizational security measures to protect your personal information. However, no method of transmission over the Internet is 100% secure, and we cannot guarantee absolute security.',
      'icon': Icons.lock,
    },
    {
      'title': 'Your Rights',
      'content':
      'You have the right to access, correct, or delete your personal information. You can also object to processing, request data portability, and withdraw consent at any time. Contact us to exercise these rights.',
      'icon': Icons.verified_user,
    },
    {
      'title': 'Cookies and Tracking',
      'content':
      'We use cookies and similar tracking technologies to track activity on our services and hold certain information. You can instruct your browser to refuse all cookies or indicate when a cookie is being sent.',
      'icon': Icons.cookie,
    },
    {
      'title': 'Third-Party Services',
      'content':
      'Our services may contain links to third-party websites or services. We have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.',
      'icon': Icons.link,
    },
    {
      'title': 'Children\'s Privacy',
      'content':
      'Our services are not intended for individuals under the age of 18. We do not knowingly collect personal information from children. If you are a parent and believe your child has provided us with information, contact us.',
      'icon': Icons.child_care,
    },
    {
      'title': 'Changes to This Policy',
      'content':
      'We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the "Last Updated" date.',
      'icon': Icons.update,
    },
    {
      'title': 'International Data Transfers',
      'content':
      'Your information may be transferred to and maintained on computers located outside of your country where data protection laws may differ. We ensure appropriate safeguards are in place for such transfers.',
      'icon': Icons.language,
    },
    {
      'title': 'Contact Us',
      'content':
      'If you have any questions about this Privacy Policy, please contact us at privacy@spy-darecordings.com or through our website contact form.',
      'icon': Icons.contact_mail,
    },
  ];

  final List<Map<String, dynamic>> _dataPractices = [
    {
      'title': 'Data Collection',
      'items': [
        'Account registration information',
        'Payment and billing details',
        'Music content and metadata',
        'Website usage analytics',
        'Communication preferences'
      ],
    },
    {
      'title': 'Data Protection',
      'items': [
        'Encryption of sensitive data',
        'Regular security audits',
        'Access controls and authentication',
        'Data backup procedures',
        'Employee privacy training'
      ],
    },
    {
      'title': 'Your Choices',
      'items': [
        'Opt-out of marketing emails',
        'Manage cookie preferences',
        'Update account information',
        'Request data deletion',
        'Export your personal data'
      ],
    },
  ];

  bool _acceptedCookies = true;
  bool _marketingEmails = false;

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
                // App Bar - Removed back button
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
                      'Privacy Policy',
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
                          padding: EdgeInsets.all(
                              constraints.maxWidth > 600 ? 20.r : 16.r),
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.privacy_tip,
                                size: constraints.maxWidth > 600 ? 44.sp : 36.sp,
                                color: AppColors.pureRed,
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                'Spy-Da Recordings Privacy Policy',
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
                                'Last Updated: December 2023',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: Colors.white70,
                                  fontSize: constraints.maxWidth > 600 ? 14.sp : 12.sp,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 8.h),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 6.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.pureRed.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Text(
                                  'GDPR Compliant',
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppColors.pureRed,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                    constraints.maxWidth > 600 ? 12.sp : 11.sp,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Data Practices
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth > 600 ? 24.w : 16.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Our Data Practices',
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

                // Data Practices - Fixed to use a SliverList with properly constrained ExpansionTiles
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth > 600 ? 24.w : 16.w,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        final practice = _dataPractices[index];
                        return Container(
                          margin: EdgeInsets.only(
                              bottom: constraints.maxWidth > 600 ? 12.h : 8.h),
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
                                    practice['title'],
                                    style: AppTextStyles.titleMedium.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                      constraints.maxWidth > 600 ? 14.sp : 12.sp,
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
                                    children: (practice['items'] as List<String>)
                                        .map((item) => Padding(
                                      padding: EdgeInsets.only(bottom: 8.h),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 4.h),
                                            child: Icon(
                                              Icons.circle,
                                              size: 8.sp,
                                              color: AppColors.pureRed,
                                            ),
                                          ),
                                          SizedBox(width: 8.w),
                                          Expanded(
                                            child: Text(
                                              item,
                                              style: AppTextStyles.bodyMedium
                                                  .copyWith(
                                                color: Colors.white70,
                                                fontSize: constraints
                                                    .maxWidth >
                                                    600
                                                    ? 12.sp
                                                    : 11.sp,
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
                      childCount: _dataPractices.length,
                    ),
                  ),
                ),

                // Privacy Settings
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.all(constraints.maxWidth > 600 ? 16.r : 12.r),
                    padding: EdgeInsets.all(constraints.maxWidth > 600 ? 16.r : 12.r),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Privacy Preferences',
                          style: AppTextStyles.titleMedium.copyWith(
                            color: Colors.white,
                            fontSize: constraints.maxWidth > 600 ? 16.sp : 14.sp,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            'Essential Cookies',
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: Colors.white,
                              fontSize: constraints.maxWidth > 600 ? 14.sp : 12.sp,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            'Required for site functionality',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: Colors.white70,
                              fontSize: constraints.maxWidth > 600 ? 12.sp : 11.sp,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          value: _acceptedCookies,
                          onChanged: null, // Essential cookies cannot be disabled
                          activeColor: AppColors.pureRed,
                        ),
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            'Marketing Emails',
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: Colors.white,
                              fontSize: constraints.maxWidth > 600 ? 14.sp : 12.sp,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            'Receive updates and promotions',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: Colors.white70,
                              fontSize: constraints.maxWidth > 600 ? 12.sp : 11.sp,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          value: _marketingEmails,
                          onChanged: (value) {
                            setState(() {
                              _marketingEmails = value;
                            });
                            _showPreferenceSaved();
                          },
                          activeColor: AppColors.pureRed,
                        ),
                        SizedBox(height: 12.h),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: _manageAllPreferences,
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: AppColors.pureRed),
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                            ),
                            child: Text(
                              'Manage All Preferences',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.pureRed,
                                fontSize: constraints.maxWidth > 600 ? 14.sp : 12.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Full Privacy Policy
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      constraints.maxWidth > 600 ? 24.w : 16.w,
                      constraints.maxWidth > 600 ? 24.h : 20.h,
                      constraints.maxWidth > 600 ? 24.w : 16.w,
                      0,
                    ),
                    child: Text(
                      'Full Privacy Policy',
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
                        padding:
                        EdgeInsets.all(constraints.maxWidth > 600 ? 16.r : 12.r),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(
                                  constraints.maxWidth > 600 ? 10.r : 8.r),
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
                            SizedBox(
                                width: constraints.maxWidth > 600 ? 16.w : 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${index + 1}. ${section['title']}',
                                    style: AppTextStyles.titleMedium.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                      constraints.maxWidth > 600 ? 14.sp : 12.sp,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(
                                    section['content'],
                                    style: AppTextStyles.bodyMedium.copyWith(
                                      color: Colors.white70,
                                      fontSize:
                                      constraints.maxWidth > 600 ? 12.sp : 11.sp,
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

                // Data Rights
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
                        Row(
                          children: [
                            Icon(
                              Icons.gavel,
                              color: AppColors.pureRed,
                              size: constraints.maxWidth > 600 ? 24.sp : 20.sp,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                'Your Data Rights',
                                style: AppTextStyles.titleLarge.copyWith(
                                  color: Colors.white,
                                  fontSize: constraints.maxWidth > 600 ? 20.sp : 18.sp,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          'Under data protection laws, you have rights including:',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Colors.white,
                            fontSize: constraints.maxWidth > 600 ? 14.sp : 12.sp,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 12.h),
                        _buildRightItem('Right to Access',
                            'Request copies of your personal data', constraints),
                        _buildRightItem(
                            'Right to Rectification',
                            'Request correction of inaccurate data',
                            constraints),
                        _buildRightItem('Right to Erasure',
                            'Request deletion of your personal data', constraints),
                        _buildRightItem('Right to Restrict Processing',
                            'Request restriction of processing', constraints),
                        _buildRightItem('Right to Data Portability',
                            'Request transfer of your data', constraints),
                        _buildRightItem('Right to Object',
                            'Object to our processing of your data', constraints),
                        SizedBox(height: 16.h),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _requestDataAction,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.pureRed,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: Text(
                              'Exercise Your Rights',
                              style: AppTextStyles.button.copyWith(
                                fontSize: constraints.maxWidth > 600 ? 16.sp : 14.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Contact Information
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
                          'Contact Our Privacy Team',
                          style: AppTextStyles.titleMedium.copyWith(
                            color: Colors.white,
                            fontSize: constraints.maxWidth > 600 ? 18.sp : 16.sp,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'For privacy-related inquiries or to exercise your rights:',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Colors.white70,
                            fontSize: constraints.maxWidth > 600 ? 14.sp : 12.sp,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 12.h),
                        _buildContactItem(
                            Icons.email, 'info@spy-damusic.com', constraints),
                        _buildContactItem(
                            Icons.phone, '+44 (0) 207 101 4363', constraints),
                        _buildContactItem(
                            Icons.access_time, 'Mon-Fri, 9AM-5PM GMT', constraints),
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

  Widget _buildRightItem(
      String title, String description, BoxConstraints constraints) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Icon(
              Icons.check_circle,
              size: constraints.maxWidth > 600 ? 16.sp : 14.sp,
              color: AppColors.pureRed,
            ),
          ),
          SizedBox(width: constraints.maxWidth > 600 ? 12.w : 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: constraints.maxWidth > 600 ? 14.sp : 12.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  description,
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
        ],
      ),
    );
  }

  Widget _buildContactItem(
      IconData icon, String text, BoxConstraints constraints) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          Icon(
            icon,
            size: constraints.maxWidth > 600 ? 18.sp : 16.sp,
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

  void _showPreferenceSaved() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Preference saved successfully'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _manageAllPreferences() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          'Manage All Privacy Preferences',
          style: AppTextStyles.titleMedium.copyWith(
            color: Colors.white,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Configure all your privacy settings in detail:',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 16.h),
              ListTile(
                title: Text(
                  'Analytics Cookies',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.white,
                  ),
                ),
                trailing: Switch(
                  value: true,
                  onChanged: (value) {},
                  activeColor: AppColors.pureRed,
                ),
              ),
              ListTile(
                title: Text(
                  'Personalized Ads',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.white,
                  ),
                ),
                trailing: Switch(
                  value: false,
                  onChanged: (value) {},
                  activeColor: AppColors.pureRed,
                ),
              ),
              ListTile(
                title: Text(
                  'Data Sharing with Partners',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.white,
                  ),
                ),
                trailing: Switch(
                  value: false,
                  onChanged: (value) {},
                  activeColor: AppColors.pureRed,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.white70,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showPreferenceSaved();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.pureRed,
            ),
            child: Text(
              'Save All',
              style: AppTextStyles.button,
            ),
          ),
        ],
      ),
    );
  }

  void _requestDataAction() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          'Exercise Your Data Rights',
          style: AppTextStyles.titleMedium.copyWith(
            color: Colors.white,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select the action you would like to take:',
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 16.h),
            ListTile(
              leading: Icon(Icons.download, color: AppColors.pureRed),
              title: Text(
                'Download My Data',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                _showRequestSent('data download');
              },
            ),
            ListTile(
              leading: Icon(Icons.edit, color: AppColors.pureRed),
              title: Text(
                'Correct My Information',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                _showRequestSent('information correction');
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: AppColors.pureRed),
              title: Text(
                'Delete My Account',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                _showRequestSent('account deletion');
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showRequestSent(String action) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Your $action request has been submitted'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      ),
    );
  }
}
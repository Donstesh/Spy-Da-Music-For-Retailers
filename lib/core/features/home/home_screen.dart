import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../webpages/view_plans_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _features = [
    {
      'icon': Icons.music_note,
      'title': 'Music Distribution',
      'description': 'Get your music on all major streaming platforms worldwide',
      'color': AppColors.pureRed.withOpacity(0.9),
    },
    {
      'icon': Icons.album,
      'title': 'Physical Releases',
      'description': 'CD, Vinyl, and merchandise manufacturing and distribution',
      'color': Colors.grey[900]!,
    },
    {
      'icon': Icons.campaign,
      'title': 'Marketing',
      'description': 'Complete promotion and social media marketing solutions',
      'color': AppColors.pureRed.withOpacity(0.8),
    },
    {
      'icon': Icons.store,
      'title': 'Retail Services',
      'description': 'Background music solutions for retail businesses',
      'color': Colors.blueGrey[800]!,
    },
  ];

  final List<Map<String, dynamic>> _testimonials = [
    {
      'name': 'DJ Prodigy',
      'role': 'Electronic Artist',
      'text': 'Spy-da helped me reach global audiences. Professional service!',
    },
    {
      'name': 'Retail Chain UK',
      'role': 'Store Manager',
      'text': 'Perfect background music for our stores. Customers love it!',
    },
    {
      'name': 'Indie Band',
      'role': 'Rock Group',
      'text': 'From recording to distribution, they handled everything.',
    },
  ];

  final List<String> _partnerLogos = [
    '🎵 Spotify',
    '🍎 Apple Music',
    '▶️ YouTube',
    '📻 Amazon Music',
    '🎧 Deezer',
    '📀 Beatport',
  ];

  // Carousel images
  final List<String> _carouselImages = [
    'assets/images/onboarding1.jpg',
    'assets/images/onboarding2.jpg',
    'assets/images/onboarding3.jpg',
  ];

  int _currentImageIndex = 0;
  late PageController _pageController;
  late Timer _carouselTimer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    // Start auto carousel
    _carouselTimer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentImageIndex < _carouselImages.length - 1) {
        _currentImageIndex++;
      } else {
        _currentImageIndex = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentImageIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _carouselTimer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  // Get current year for copyright
  String get _currentYear {
    return DateTime.now().year.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return CustomScrollView(
            slivers: [
              // Hero Section with Image Carousel
              SliverAppBar(
                backgroundColor: Colors.black,
                expandedHeight: constraints.maxHeight * 0.35,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  titlePadding: EdgeInsets.only(bottom: 16.h),
                  title: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      'SPY-DA RECORDINGS',
                      style: AppTextStyles.headlineLarge.copyWith(
                        color: Colors.white,
                        fontSize: constraints.maxWidth > 600 ? 20.sp : 16.sp,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  background: Stack(
                    children: [
                      // Image Carousel
                      PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentImageIndex = index;
                          });
                        },
                        itemCount: _carouselImages.length,
                        itemBuilder: (context, index) {
                          return Container(
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
                            child: Image.asset(
                              _carouselImages[index],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                // Fallback image if asset doesn't exist
                                return Container(
                                  color: Colors.grey[900],
                                  child: Center(
                                    child: Icon(
                                      Icons.music_note,
                                      size: 60.sp,
                                      color: AppColors.pureRed,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),

                      // Gradient overlay for better text visibility
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.3),
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                      ),

                      // Carousel Indicators
                      Positioned(
                        bottom: 20.h,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            _carouselImages.length,
                                (index) => Container(
                              width: 8.w,
                              height: 8.h,
                              margin: EdgeInsets.symmetric(horizontal: 4.w),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentImageIndex == index
                                    ? AppColors.pureRed
                                    : Colors.white.withOpacity(0.5),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Welcome Section
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth > 600 ? 32.w : 16.w,
                    vertical: 20.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome to Spy-da Recordings',
                        style: AppTextStyles.headlineLarge.copyWith(
                          color: Colors.white,
                          fontSize: constraints.maxWidth > 600 ? 28.sp : 24.sp,
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Your complete music solution for artists and retailers',
                        style: AppTextStyles.headlineMedium.copyWith(
                          color: AppColors.pureRed,
                          fontSize: constraints.maxWidth > 600 ? 18.sp : 16.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 14.h),
                      Container(
                        padding: EdgeInsets.all(14.r),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: Text(
                          'We provide professional music distribution, marketing services, and retail background music solutions. From emerging artists to established retail chains, we have the perfect service for you.',
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: Colors.white70,
                            fontSize: constraints.maxWidth > 600 ? 16.sp : 14.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Services Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth > 600 ? 24.w : 16.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Our Services',
                        style: AppTextStyles.headlineLarge.copyWith(
                          color: Colors.white,
                          fontSize: constraints.maxWidth > 600 ? 26.sp : 22.sp,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'Comprehensive music solutions for every need',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: Colors.white70,
                          fontSize: constraints.maxWidth > 600 ? 16.sp : 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SliverPadding(
                padding: EdgeInsets.all(14.r),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: constraints.maxWidth > 600 ? 4 : 2,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 10.h,
                    childAspectRatio: constraints.maxWidth > 600 ? 0.8 : 0.9,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final feature = _features[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: feature['color'],
                          borderRadius: BorderRadius.circular(14.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(14.r),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                feature['icon'],
                                size: constraints.maxWidth > 600 ? 34.sp : 30.sp,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6.w),
                              child: Text(
                                feature['title'],
                                style: AppTextStyles.titleLarge.copyWith(
                                  color: Colors.white,
                                  fontSize: constraints.maxWidth > 600 ? 16.sp : 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6.w),
                              child: Text(
                                feature['description'],
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: Colors.white70,
                                  fontSize: constraints.maxWidth > 600 ? 12.sp : 11.sp,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: _features.length,
                  ),
                ),
              ),

              // Retail Packages Section
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.all(14.r),
                  padding: EdgeInsets.all(18.r),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.pureRed.withOpacity(0.9),
                        Colors.black87,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(14.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.pureRed.withOpacity(0.3),
                        blurRadius: 12,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.store,
                            size: constraints.maxWidth > 600 ? 26.sp : 22.sp,
                            color: Colors.white,
                          ),
                          SizedBox(width: 6.w),
                          Flexible(
                            child: Text(
                              'Retail Music Packages',
                              style: AppTextStyles.headlineMedium.copyWith(
                                color: Colors.white,
                                fontSize: constraints.maxWidth > 600 ? 20.sp : 18.sp,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Professional background music solutions for retail stores',
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: Colors.white70,
                          fontSize: constraints.maxWidth > 600 ? 16.sp : 14.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 14.h),
                      Wrap(
                        spacing: 6.w,
                        runSpacing: 6.h,
                        alignment: WrapAlignment.center,
                        children: [
                          _buildRetailPackage('Basic', '£149.99', '/Year', Icons.music_note, constraints),
                          _buildRetailPackage('Premium', '£179.99', '/Year', Icons.graphic_eq, constraints),
                          _buildRetailPackage('Elite', '£199.99', '/Year', Icons.star, constraints),
                        ],
                      ),
                      SizedBox(height: 18.h),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewPlansScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(
                              vertical: 12.h,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22.r),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'View All Packages',
                                style: AppTextStyles.button.copyWith(
                                  color: Colors.black,
                                  fontSize: constraints.maxWidth > 600 ? 16.sp : 14.sp,
                                ),
                              ),
                              SizedBox(width: 6.w),
                              Icon(Icons.arrow_forward, size: 16.sp),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Distribution Partners
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.all(14.r),
                  padding: EdgeInsets.all(18.r),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Distributed Worldwide',
                        style: AppTextStyles.titleLarge.copyWith(
                          color: Colors.white,
                          fontSize: constraints.maxWidth > 600 ? 20.sp : 18.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'We distribute to all major platforms',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: Colors.white70,
                          fontSize: constraints.maxWidth > 600 ? 16.sp : 14.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 14.h),
                      Wrap(
                        spacing: 10.w,
                        runSpacing: 10.h,
                        alignment: WrapAlignment.center,
                        children: _partnerLogos
                            .map((logo) => Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: Colors.white30,
                            ),
                          ),
                          child: Text(
                            logo,
                            style: AppTextStyles.titleMedium.copyWith(
                              color: Colors.white,
                              fontSize: constraints.maxWidth > 600 ? 16.sp : 14.sp,
                            ),
                          ),
                        ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),

              // Testimonials
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth > 600 ? 24.w : 16.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'What Our Clients Say',
                        style: AppTextStyles.headlineLarge.copyWith(
                          color: Colors.white,
                          fontSize: constraints.maxWidth > 600 ? 26.sp : 22.sp,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'Trusted by artists and retailers worldwide',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: Colors.white70,
                          fontSize: constraints.maxWidth > 600 ? 16.sp : 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: SizedBox(
                  height: 180.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.all(14.r),
                    itemCount: _testimonials.length,
                    itemBuilder: (context, index) {
                      final testimonial = _testimonials[index];
                      return Container(
                        width: constraints.maxWidth > 600 ? 280.w : 260.w,
                        margin: EdgeInsets.only(right: 10.w),
                        padding: EdgeInsets.all(14.r),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 36.w,
                                  height: 36.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.pureRed,
                                  ),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 22.sp,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        testimonial['name'],
                                        style: AppTextStyles.titleMedium.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: constraints.maxWidth > 600 ? 16.sp : 14.sp,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 2.h),
                                      Text(
                                        testimonial['role'],
                                        style: AppTextStyles.bodySmall.copyWith(
                                          color: AppColors.pureRed,
                                          fontSize: constraints.maxWidth > 600 ? 14.sp : 12.sp,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Expanded(
                              child: Text(
                                '"${testimonial['text']}"',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: Colors.white70,
                                  fontStyle: FontStyle.italic,
                                  fontSize: constraints.maxWidth > 600 ? 15.sp : 13.sp,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              children: List.generate(
                                5,
                                    (starIndex) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 12.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Stats Section - Responsive
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.all(14.r),
                  padding: EdgeInsets.all(18.r),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.black,
                        Colors.grey[900]!,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: constraints.maxWidth > 600
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem('10K+', 'Tracks', Icons.library_music, constraints),
                      _buildStatItem('500+', 'Artists', Icons.people, constraints),
                      _buildStatItem('100+', 'Retailers', Icons.store, constraints),
                      _buildStatItem('50+', 'Countries', Icons.public, constraints),
                    ],
                  )
                      : Wrap(
                    spacing: 16.w,
                    runSpacing: 16.h,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildStatItem('10K+', 'Tracks', Icons.library_music, constraints),
                      _buildStatItem('500+', 'Artists', Icons.people, constraints),
                      _buildStatItem('100+', 'Retailers', Icons.store, constraints),
                      _buildStatItem('50+', 'Countries', Icons.public, constraints),
                    ],
                  ),
                ),
              ),

              // CTA Section
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.all(14.r),
                  padding: EdgeInsets.all(18.r),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.pureRed.withOpacity(0.9),
                        Colors.black87,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(14.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.pureRed.withOpacity(0.3),
                        blurRadius: 12,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Ready to Elevate Your Music?',
                        style: AppTextStyles.headlineMedium.copyWith(
                          color: Colors.white,
                          fontSize: constraints.maxWidth > 600 ? 24.sp : 20.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'Join thousands of artists and retailers using Spy-da Recordings',
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: Colors.white70,
                          fontSize: constraints.maxWidth > 600 ? 16.sp : 14.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 18.h),
                      constraints.maxWidth > 600
                          ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6.w),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Navigate to artist services
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 14.h,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22.r),
                                  ),
                                ),
                                child: Text(
                                  'For Artists',
                                  style: AppTextStyles.button.copyWith(
                                    color: Colors.black,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6.w),
                              child: OutlinedButton(
                                onPressed: () {
                                  // Navigate to retail services
                                },
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: Colors.white),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 14.h,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22.r),
                                  ),
                                ),
                                child: Text(
                                  'For Retailers',
                                  style: AppTextStyles.button.copyWith(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                          : Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                // Navigate to artist services
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                padding: EdgeInsets.symmetric(
                                  vertical: 12.h,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22.r),
                                ),
                              ),
                              child: Text(
                                'For Artists',
                                style: AppTextStyles.button.copyWith(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {
                                // Navigate to retail services
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.white),
                                padding: EdgeInsets.symmetric(
                                  vertical: 12.h,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22.r),
                                ),
                              ),
                              child: Text(
                                'For Retailers',
                                style: AppTextStyles.button.copyWith(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Footer
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.all(18.r),
                  color: Colors.black,
                  child: Column(
                    children: [
                      Icon(
                        Icons.music_note,
                        size: 28.sp,
                        color: AppColors.pureRed,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'SPY-DA RECORDINGS',
                        style: AppTextStyles.titleLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                          fontSize: constraints.maxWidth > 600 ? 20.sp : 18.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Professional Music Solutions',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: Colors.white70,
                          fontSize: constraints.maxWidth > 600 ? 16.sp : 14.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 14.h),
                      Text(
                        '© $_currentYear Spy-da Recordings. All rights reserved.',
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.white30,
                          fontSize: constraints.maxWidth > 600 ? 14.sp : 12.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildRetailPackage(
      String name, String price, String period, IconData icon, BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth > 600 ? 120.w : 100.w,
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: constraints.maxWidth > 600 ? 24.sp : 22.sp,
            color: Colors.white,
          ),
          SizedBox(height: 6.h),
          Text(
            name,
            style: AppTextStyles.titleMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: constraints.maxWidth > 600 ? 16.sp : 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          Text(
            price,
            style: AppTextStyles.headlineMedium.copyWith(
              color: AppColors.pureRed,
              fontSize: constraints.maxWidth > 600 ? 20.sp : 18.sp,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            period,
            style: AppTextStyles.caption.copyWith(
              color: Colors.white70,
              fontSize: constraints.maxWidth > 600 ? 12.sp : 11.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String number, String label, IconData icon, BoxConstraints constraints) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppColors.pureRed,
          size: constraints.maxWidth > 600 ? 26.sp : 22.sp,
        ),
        SizedBox(height: 6.h),
        Text(
          number,
          style: AppTextStyles.headlineLarge.copyWith(
            color: Colors.white,
            fontSize: constraints.maxWidth > 600 ? 22.sp : 20.sp,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: Colors.white70,
            fontSize: constraints.maxWidth > 600 ? 14.sp : 12.sp,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
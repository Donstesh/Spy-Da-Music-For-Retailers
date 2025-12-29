import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/utils/app_preferences.dart';
import 'terms_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      imagePath: 'assets/images/onboarding1.jpg',
      title: '🎧 Welcome to Spy-da Music',
      subtitle: 'Discover a world of uplifting, clean music curated to move your soul.',
    ),
    OnboardingPage(
      imagePath: 'assets/images/onboarding2.jpg',
      title: '🚀 Hear It Here First',
      subtitle: 'Full tracks available on Spy-da Music before they hit DSPs. Stay ahead.',
    ),
    OnboardingPage(
      imagePath: 'assets/images/onboarding3.jpg',
      title: '💰 Support & Earn',
      subtitle: 'Support artists. Earn tokens by sharing. Your vibe has value.',
    ),
    OnboardingPage(
      imagePath: 'assets/images/onboarding4.jpg',
      title: '🎵 Your Sound. Your Movement.',
      subtitle: 'Join the Spy-da community and amplify real music with purpose.',
      isLastPage: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) => _pages[index],
          ),
          // Skip button
          if (_currentPage < _pages.length - 1)
            Positioned(
              top: MediaQuery.of(context).padding.top + 20.h,
              right: 20.w,
              child: TextButton(
                onPressed: _completeOnboarding,
                child: Text(
                  'Skip',
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
              ),
            ),
          // Bottom controls
          Positioned(
            bottom: 40.h,
            left: 0,
            right: 0,
            child: Column(
              children: [
                SmoothPageIndicator(
                  controller: _pageController,
                  count: _pages.length,
                  effect: WormEffect(
                    dotHeight: 10.h,
                    dotWidth: 10.w,
                    activeDotColor: Colors.white,
                    dotColor: Colors.white54,
                  ),
                ),
                SizedBox(height: 30.h),
                _currentPage == _pages.length - 1
                    ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                          ),
                          onPressed: _completeOnboarding,
                          child: Text(
                            'Get Started',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                    : IconButton(
                  onPressed: () => _pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  ),
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 40.w,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _completeOnboarding() async {
    await AppPreferences.setFirstLaunchComplete();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const TermsScreen()),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final bool isLastPage;

  const OnboardingPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    this.isLastPage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withOpacity(0.7),
              Colors.black.withOpacity(0.3),
            ],
          ),
        ),
        padding: EdgeInsets.all(40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
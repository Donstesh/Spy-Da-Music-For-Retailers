import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class ViewPlansScreen extends StatefulWidget {
  const ViewPlansScreen({super.key});

  @override
  State<ViewPlansScreen> createState() => _ViewPlansScreenState();
}

class _ViewPlansScreenState extends State<ViewPlansScreen> {
  int _selectedPackageIndex = 0;

  final List<Map<String, dynamic>> _retailPackages = [
    {
      'id': 'basic',
      'title': 'Retail - Basic',
      'icon': Icons.music_note,
      'description': 'Basic Tier - Perfect for small shops',
      'fullDescription': 'Basic Tier - Features: \n• Access to curated playlists updated monthly.\n• Suitable for small shops.\n• Ideal For: Shops looking for a simple music solution to create a pleasant ambience.',
      'priceNote': '£149.99 on Yearly Subscription.',
      'color': Colors.blueGrey[800]!,
      'price': '£ 149.99',
      'period': '/ Year',
      'features': [
        'Access to curated playlists updated monthly',
        'Suitable for small shops',
        'Simple music solution for pleasant ambience',
        'Basic customer support',
        'Standard audio quality',
        'Yearly subscription',
      ],
      'popular': false,
    },
    {
      'id': 'premium',
      'title': 'Retail - Premium',
      'icon': Icons.graphic_eq,
      'description': 'Premium Tier - Dynamic playlists for medium stores',
      'fullDescription': 'Premium Tier - Features: \n• Curated playlists updated bi-weekly.\n• Playlists tailored for peak hours and specific store moods.\n• Ideal For: Medium-sized stores that want dynamic playlist updates.',
      'priceNote': '£179.99 on Yearly Subscription.',
      'color': AppColors.pureRed.withOpacity(0.9),
      'price': '£ 179.99',
      'period': '/ Year',
      'features': [
        'Curated playlists updated bi-weekly',
        'Playlists tailored for peak hours',
        'Specific store moods selection',
        'Medium-sized store optimization',
        'Dynamic playlist updates',
        'Enhanced audio quality',
      ],
      'popular': true,
    },
    {
      'id': 'elite',
      'title': 'Retail - Elite',
      'icon': Icons.star,
      'description': 'Elite Tier - Tailored solutions for large retailers',
      'fullDescription': 'Elite Tier - Features: \n• Weekly updated playlists customized for your brand.\n• Continuous play feature: Set it and forget it – the music will play all day on repeat.\n• Priority support for specific playlist requests.\n• Ideal For: Large retailers or chains that require tailored music solutions to reflect their brand identity.',
      'priceNote': '£199.99 on Yearly Subscription.',
      'color': Colors.amber[800]!,
      'price': '£ 199.99',
      'period': '/ Year',
      'features': [
        'Weekly updated customized playlists',
        'Brand-customized music solutions',
        'Continuous play feature - set and forget',
        'Music plays all day on repeat',
        'Priority support for requests',
        'Premium audio quality',
        'Large retailer/chain optimized',
      ],
      'popular': false,
    },
  ];

  void _showPackageDetails(BuildContext context, Map<String, dynamic> package) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Container(
            padding: EdgeInsets.all(20.r),
            width: MediaQuery.of(context).size.width * 0.9,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: package['color'].withOpacity(0.5),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.r),
                        decoration: BoxDecoration(
                          color: package['color'],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          package['icon'],
                          size: 24.sp,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.white70, size: 20.sp),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    package['title'],
                    style: AppTextStyles.titleLarge.copyWith(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Text(
                        package['price'],
                        style: AppTextStyles.headlineMedium.copyWith(
                          color: AppColors.pureRed,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        package['period'],
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: Colors.white70,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Divider(color: Colors.white30),
                  SizedBox(height: 16.h),
                  Text(
                    'Package Details',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    package['fullDescription'],
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Colors.white70,
                      fontSize: 14.sp,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Features Included:',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: Colors.white,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Column(
                    children: (package['features'] as List<String>)
                        .map((feature) => Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 16.sp,
                            color: AppColors.pureRed,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              feature,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: Colors.white70,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
                        .toList(),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info,
                          color: AppColors.pureRed,
                          size: 16.sp,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            package['priceNote'],
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: Colors.white70,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Handle subscription logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: package['color'],
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Subscribe Now',
                        style: AppTextStyles.button.copyWith(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showNewsletterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Container(
            padding: EdgeInsets.all(24.r),
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: AppColors.pureRed.withOpacity(0.5),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.email,
                    size: 40.sp,
                    color: AppColors.pureRed,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Subscribe to Newsletter',
                    style: AppTextStyles.titleLarge.copyWith(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Get updates on new playlists, special offers, and retail music insights',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Colors.white70,
                      fontSize: 14.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.h),
                  TextField(
                    style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Enter your email address',
                      hintStyle: AppTextStyles.bodyMedium.copyWith(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.grey[900],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 14.h,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Thank you for subscribing to our newsletter!',
                              style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
                            ),
                            backgroundColor: AppColors.pureRed,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.pureRed,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Subscribe Now',
                        style: AppTextStyles.button.copyWith(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Maybe Later',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.white70,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

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
                // App Bar - Same as Privacy and Terms screens
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
                      'Retail Music Packages',
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

                // Welcome Section
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
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.audiotrack,
                                size: constraints.maxWidth > 600 ? 44.sp : 36.sp,
                                color: AppColors.pureRed,
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                'Choose Your Retail Music Plan',
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
                                'Professional background music solutions tailored for retail stores',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: Colors.white70,
                                  fontSize: constraints.maxWidth > 600 ? 14.sp : 12.sp,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
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
                                  'All Plans Include Commercial License',
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppColors.pureRed,
                                    fontWeight: FontWeight.bold,
                                    fontSize: constraints.maxWidth > 600 ? 12.sp : 11.sp,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          padding: EdgeInsets.all(12.r),
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: AppColors.pureRed.withOpacity(0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info,
                                color: AppColors.pureRed,
                                size: constraints.maxWidth > 600 ? 20.sp : 18.sp,
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  'All packages include commercial licensing and year-round updates',
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: Colors.white70,
                                    fontSize: constraints.maxWidth > 600 ? 14.sp : 12.sp,
                                  ),
                                  maxLines: 2,
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

                // Package Selection Tabs
                SliverToBoxAdapter(
                  child: Container(
                    height: constraints.maxWidth > 600 ? 60.h : 50.h,
                    margin: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth > 600 ? 24.w : 16.w,
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _retailPackages.length,
                      itemBuilder: (context, index) {
                        final package = _retailPackages[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedPackageIndex = index;
                            });
                          },
                          child: Container(
                            constraints: BoxConstraints(
                              minWidth: constraints.maxWidth > 600 ? 120.w : 100.w,
                            ),
                            margin: EdgeInsets.only(
                                right: constraints.maxWidth > 600 ? 8.w : 6.w),
                            padding: EdgeInsets.symmetric(
                              horizontal: constraints.maxWidth > 600 ? 16.w : 12.w,
                              vertical: constraints.maxWidth > 600 ? 10.h : 8.h,
                            ),
                            decoration: BoxDecoration(
                              color: _selectedPackageIndex == index
                                  ? package['color']
                                  : Colors.grey[900],
                              borderRadius: BorderRadius.circular(25.r),
                              border: _selectedPackageIndex == index
                                  ? Border.all(
                                color: Colors.white.withOpacity(0.3),
                                width: 1.5,
                              )
                                  : null,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  package['title'].split(' - ')[1],
                                  style: AppTextStyles.bodyLarge.copyWith(
                                    color: Colors.white,
                                    fontWeight: _selectedPackageIndex == index
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    fontSize: constraints.maxWidth > 600 ? 13.sp : 11.sp,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  package['price'],
                                  style: AppTextStyles.titleMedium.copyWith(
                                    color: _selectedPackageIndex == index
                                        ? Colors.white
                                        : AppColors.pureRed,
                                    fontWeight: FontWeight.bold,
                                    fontSize: constraints.maxWidth > 600 ? 15.sp : 13.sp,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Package Cards
                SliverPadding(
                  padding: EdgeInsets.all(constraints.maxWidth > 600 ? 16.r : 12.r),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: constraints.maxWidth > 600 ? 3 : 1,
                      crossAxisSpacing: constraints.maxWidth > 600 ? 12.w : 8.w,
                      mainAxisSpacing: constraints.maxWidth > 600 ? 12.h : 8.h,
                      childAspectRatio: constraints.maxWidth > 600 ? 0.75 : 1.5,
                    ),
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        final package = _retailPackages[index];
                        return _buildPackageCard(package, index, constraints);
                      },
                      childCount: _retailPackages.length,
                    ),
                  ),
                ),

                // Selected Package Details
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.all(constraints.maxWidth > 600 ? 16.r : 12.r),
                    padding: EdgeInsets.all(constraints.maxWidth > 600 ? 20.r : 16.r),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          _retailPackages[_selectedPackageIndex]['color']
                              .withOpacity(0.3),
                          Colors.black,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: _retailPackages[_selectedPackageIndex]['color']
                            .withOpacity(0.5),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10.r),
                              decoration: BoxDecoration(
                                color: _retailPackages[_selectedPackageIndex]
                                ['color'],
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _retailPackages[_selectedPackageIndex]['icon'],
                                size: constraints.maxWidth > 600 ? 24.sp : 20.sp,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _retailPackages[_selectedPackageIndex]['title'],
                                    style: AppTextStyles.titleLarge.copyWith(
                                      color: Colors.white,
                                      fontSize: constraints.maxWidth > 600 ? 18.sp : 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 4.h),
                                  Row(
                                    children: [
                                      Text(
                                        _retailPackages[_selectedPackageIndex]
                                        ['price'],
                                        style: AppTextStyles.headlineMedium.copyWith(
                                          color: AppColors.pureRed,
                                          fontSize: constraints.maxWidth > 600 ? 24.sp : 20.sp,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(width: 4.w),
                                      Text(
                                        _retailPackages[_selectedPackageIndex]
                                        ['period'],
                                        style: AppTextStyles.bodyLarge.copyWith(
                                          color: Colors.white70,
                                          fontSize: constraints.maxWidth > 600 ? 14.sp : 12.sp,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Package Features',
                          style: AppTextStyles.titleMedium.copyWith(
                            color: Colors.white,
                            fontSize: constraints.maxWidth > 600 ? 16.sp : 14.sp,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Column(
                          children: (_retailPackages[_selectedPackageIndex]
                          ['features'] as List<String>)
                              .map((feature) => Padding(
                            padding: EdgeInsets.only(bottom: 6.h),
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: constraints.maxWidth > 600
                                      ? 16.sp
                                      : 14.sp,
                                  color: AppColors.pureRed,
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Text(
                                    feature,
                                    style: AppTextStyles.bodyMedium.copyWith(
                                      color: Colors.white70,
                                      fontSize: constraints.maxWidth > 600
                                          ? 14.sp
                                          : 12.sp,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ))
                              .toList(),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          _retailPackages[_selectedPackageIndex]['description'],
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

                // Comparison Table
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
                          'Package Comparison',
                          style: AppTextStyles.titleLarge.copyWith(
                            color: Colors.white,
                            fontSize: constraints.maxWidth > 600 ? 18.sp : 16.sp,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: MediaQuery.of(context).size.width - 32.w,
                            ),
                            child: DataTable(
                              columnSpacing: constraints.maxWidth > 600 ? 20.w : 12.w,
                              horizontalMargin: 0,
                              dataRowMinHeight: 35.h,
                              dataRowMaxHeight: 50.h,
                              headingRowHeight: 40.h,
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
                                DataColumn(
                                  label: ConstrainedBox(
                                    constraints: BoxConstraints(minWidth: 100.w),
                                    child: Text(
                                      'Feature',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: ConstrainedBox(
                                    constraints: BoxConstraints(minWidth: 70.w),
                                    child: Text(
                                      'Basic',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: ConstrainedBox(
                                    constraints: BoxConstraints(minWidth: 70.w),
                                    child: Text(
                                      'Premium',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: ConstrainedBox(
                                    constraints: BoxConstraints(minWidth: 70.w),
                                    child: Text(
                                      'Elite',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                              rows: [
                                DataRow(cells: [
                                  DataCell(Text('Playlist Updates',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                                  DataCell(Text('Monthly',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                                  DataCell(Text('Bi-weekly',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                                  DataCell(Text('Weekly',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('Audio Quality',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                                  DataCell(Text('Standard',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                                  DataCell(Text('Enhanced',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                                  DataCell(Text('Premium',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('Support',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                                  DataCell(Text('Basic',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                                  DataCell(Text('Standard',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                                  DataCell(Text('Priority',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('Customization',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                                  DataCell(Text('Limited',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                                  DataCell(Text('Moderate',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                                  DataCell(Text('Full',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('Price/Year',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                                  DataCell(Text('£149.99',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                                  DataCell(Text('£179.99',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                                  DataCell(Text('£199.99',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                                ]),
                              ],
                            ),
                          ),
                        ),
                      ],
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
                        Text(
                          'Frequently Asked Questions',
                          style: AppTextStyles.titleLarge.copyWith(
                            color: Colors.white,
                            fontSize: constraints.maxWidth > 600 ? 18.sp : 16.sp,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        _buildFAQItem(
                          'Can I switch between packages?',
                          'Yes, you can upgrade or downgrade your package at any time. Changes take effect at the start of your next billing cycle.',
                          constraints,
                        ),
                        _buildFAQItem(
                          'Is there a contract?',
                          'All packages are yearly subscriptions. You can cancel before renewal, but no refunds are provided for partial periods.',
                          constraints,
                        ),
                        _buildFAQItem(
                          'What audio quality is provided?',
                          'Basic: 128kbps, Premium: 192kbps, Elite: 320kbps MP3 quality. All suitable for commercial retail environments.',
                          constraints,
                        ),
                        _buildFAQItem(
                          'How are playlists updated?',
                          'Updates are automatic. New playlists are added to your account according to your package schedule.',
                          constraints,
                        ),
                        _buildFAQItem(
                          'Do I need special equipment?',
                          'No, our service works with any standard audio system. Just connect a device with internet access.',
                          constraints,
                        ),
                      ],
                    ),
                  ),
                ),

                // CTA Section
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.all(constraints.maxWidth > 600 ? 16.r : 12.r),
                    padding: EdgeInsets.all(constraints.maxWidth > 600 ? 20.r : 16.r),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.pureRed.withOpacity(0.9),
                          Colors.black87,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.pureRed.withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Stay Updated with Our Newsletter',
                          style: AppTextStyles.headlineMedium.copyWith(
                            color: Colors.white,
                            fontSize: constraints.maxWidth > 600 ? 20.sp : 18.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Get the latest music trends, special offers, and retail insights',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Colors.white70,
                            fontSize: constraints.maxWidth > 600 ? 14.sp : 12.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16.h),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => _showNewsletterDialog(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              padding: EdgeInsets.symmetric(
                                vertical: constraints.maxWidth > 600 ? 14.h : 12.h,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.r),
                              ),
                            ),
                            child: Text(
                              'Subscribe to Newsletter',
                              style: AppTextStyles.button.copyWith(
                                color: Colors.black,
                                fontSize: constraints.maxWidth > 600 ? 16.sp : 14.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Add bottom padding
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

  Widget _buildPackageCard(
      Map<String, dynamic> package,
      int index,
      BoxConstraints constraints,
      ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPackageIndex = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: package['color'],
          borderRadius: BorderRadius.circular(12.r),
          border: _selectedPackageIndex == index
              ? Border.all(
            color: Colors.white,
            width: 2,
          )
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Stack(
          children: [
            if (package['popular'] == true)
              Positioned(
                top: 8.h,
                right: 8.w,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 3.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    'MOST POPULAR',
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: constraints.maxWidth > 600 ? 8.sp : 7.sp,
                    ),
                  ),
                ),
              ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(constraints.maxWidth > 600 ? 10.r : 8.r),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    package['icon'],
                    size: constraints.maxWidth > 600 ? 24.sp : 20.sp,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Text(
                    package['title'].split(' - ')[1],
                    style: AppTextStyles.titleMedium.copyWith(
                      color: Colors.white,
                      fontSize: constraints.maxWidth > 600 ? 14.sp : 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  package['price'],
                  style: AppTextStyles.headlineMedium.copyWith(
                    color: Colors.white,
                    fontSize: constraints.maxWidth > 600 ? 20.sp : 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  package['period'],
                  style: AppTextStyles.caption.copyWith(
                    color: Colors.white70,
                    fontSize: constraints.maxWidth > 600 ? 12.sp : 11.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 10.h),
                GestureDetector(
                  onTap: () => _showPackageDetails(context, package),
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Text(
                      'VIEW DETAILS',
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white,
                        fontSize: constraints.maxWidth > 600 ? 11.sp : 10.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer, BoxConstraints constraints) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: AppTextStyles.bodyLarge.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: constraints.maxWidth > 600 ? 14.sp : 12.sp,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          Text(
            answer,
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.white70,
              fontSize: constraints.maxWidth > 600 ? 12.sp : 11.sp,
            ),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/features/artists/screens/artists_screen.dart';
import 'core/features/contact/screens/contact_screen.dart';
import 'core/features/distribution/distribution_screen.dart';
import 'core/features/label/screens/label_screen.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/custom_drawer.dart';
import 'core/widgets/custom_bottom_nav.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentIndex = 0;
  bool _showSearchField = false;
  final TextEditingController _searchController = TextEditingController();
  late List<Widget> _screens;
  int _refreshKey = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _initializeScreens();
  }

  void _initializeScreens() {
    _screens = [
      const LabelScreen(),
      const ArtistsScreen(),
      const DistributionScreen(),
      const ContactScreen(),
    ];
  }

  void _refreshCurrentScreen() {
    setState(() {
      _refreshKey++;
      _initializeScreens();
    });

    // Show snackbar using the scaffold's context
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
        SnackBar(
          content: Text('Refreshing ${_getScreenName()}...'),
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.green,
        ),
      );
    });
  }

  void _toggleSearchField() {
    setState(() {
      _showSearchField = !_showSearchField;
      if (!_showSearchField) {
        _searchController.clear();
      }
    });
  }

  void _handleSearch(String query) {
    switch (_currentIndex) {
      case 0:
        print('Searching Labels: $query');
        break;
      case 1:
        print('Searching Artists: $query');
        break;
      case 2:
        print('Searching Distribution: $query');
        break;
      case 3:
        print('Searching Contact: $query');
        break;
    }
  }

  String _getScreenName() {
    switch (_currentIndex) {
      case 0:
        return 'Labels';
      case 1:
        return 'Artists';
      case 2:
        return 'Distribution';
      case 3:
        return 'Contact';
      default:
        return 'Screen';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          title: 'Spy-Da Music Retailer',
          theme: AppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            key: _scaffoldKey, // Use the global key
            drawer: const CustomDrawer(),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: Container(
                color: Colors.black,
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                  left: 16.w,
                  right: 16.w,
                ),
                child: Row(
                  children: [
                    // Menu button
                    Builder(
                      builder: (context) => IconButton(
                        icon: Icon(
                          _showSearchField ? Icons.close : Icons.menu,
                          color: Colors.white,
                        ),
                        onPressed: _showSearchField
                            ? () {
                          setState(() {
                            _showSearchField = false;
                            _searchController.clear();
                          });
                        }
                            : () => Scaffold.of(context).openDrawer(),
                      ),
                    ),

                    if (_showSearchField)
                    // Search field
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: TextField(
                              controller: _searchController,
                              autofocus: true,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                              ),
                              decoration: InputDecoration(
                                hintText: _getSearchHint(),
                                hintStyle: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14.sp,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 8.h,
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.grey[600],
                                  size: 20.w,
                                ),
                                suffixIcon: _searchController.text.isNotEmpty
                                    ? IconButton(
                                  icon: Icon(
                                    Icons.clear,
                                    color: Colors.grey[600],
                                    size: 18.w,
                                  ),
                                  onPressed: () {
                                    _searchController.clear();
                                    _handleSearch('');
                                  },
                                )
                                    : null,
                              ),
                              onChanged: _handleSearch,
                              onSubmitted: (value) {
                                _handleSearch(value);
                              },
                            ),
                          ),
                        ),
                      )
                    else
                    // Logo
                      Expanded(
                        child: Center(
                          child: Image.asset(
                            'assets/images/splash.jpg',
                            height: 55.h,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 40.h,
                                child: const Center(
                                  child: Text(
                                    'Spy-da Music',
                                    style: TextStyle(
                                      color: Colors.amber,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                    // Action buttons
                    if (!_showSearchField)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Search icon
                          IconButton(
                            icon: const Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            onPressed: _toggleSearchField,
                            tooltip: 'Search',
                            padding: EdgeInsets.only(right: 0.w),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.refresh,
                              color: Colors.white,
                            ),
                            onPressed: _refreshCurrentScreen,
                            tooltip: 'Refresh',
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            body: _screens[_currentIndex],
            bottomNavigationBar: CustomBottomNav(
              currentIndex: _currentIndex,
              onTap: (index) {
                if (_showSearchField) {
                  setState(() {
                    _showSearchField = false;
                    _searchController.clear();
                  });
                }
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        );
      },
    );
  }

  String _getSearchHint() {
    switch (_currentIndex) {
      case 0:
        return 'Search labels...';
      case 1:
        return 'Search artists...';
      case 2:
        return 'Search distribution...';
      case 3:
        return 'Search contacts...';
      default:
        return 'Search...';
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
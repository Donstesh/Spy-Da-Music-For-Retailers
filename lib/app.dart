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
  final Map<int, GlobalKey<RefreshableScreenState>> _refreshKeys = {
    0: GlobalKey<RefreshableScreenState>(),
    1: GlobalKey<RefreshableScreenState>(),
    2: GlobalKey<RefreshableScreenState>(),
    3: GlobalKey<RefreshableScreenState>(),
  };

  @override
  void initState() {
    super.initState();
    _screens = [
      RefreshableScreen(
        key: _refreshKeys[0],
        child: const LabelScreen(),
        onRefresh: () async {
          // Add LabelScreen refresh logic here
          print('Refreshing Label Screen');
          setState(() {
            // Recreate the screen to trigger refresh
            _screens[0] = RefreshableScreen(
              key: _refreshKeys[0],
              child: const LabelScreen(),
              onRefresh: () async {
                print('Refreshing Label Screen');
                await Future.delayed(const Duration(seconds: 1));
              },
            );
          });
          await Future.delayed(const Duration(seconds: 1));
        },
      ),
      RefreshableScreen(
        key: _refreshKeys[1],
        child: const ArtistsScreen(),
        onRefresh: () async {
          // Add ArtistsScreen refresh logic here
          print('Refreshing Artists Screen');
          setState(() {
            // Recreate the screen to trigger refresh
            _screens[1] = RefreshableScreen(
              key: _refreshKeys[1],
              child: const ArtistsScreen(),
              onRefresh: () async {
                print('Refreshing Artists Screen');
                await Future.delayed(const Duration(seconds: 1));
              },
            );
          });
          await Future.delayed(const Duration(seconds: 1));
        },
      ),
      RefreshableScreen(
        key: _refreshKeys[2],
        child: const DistributionScreen(),
        onRefresh: () async {
          // Add DistributionScreen refresh logic here
          print('Refreshing Distribution Screen');
          setState(() {
            // Recreate the screen to trigger refresh
            _screens[2] = RefreshableScreen(
              key: _refreshKeys[2],
              child: const DistributionScreen(),
              onRefresh: () async {
                print('Refreshing Distribution Screen');
                await Future.delayed(const Duration(seconds: 1));
              },
            );
          });
          await Future.delayed(const Duration(seconds: 1));
        },
      ),
      RefreshableScreen(
        key: _refreshKeys[3],
        child: const ContactScreen(),
        onRefresh: () async {
          // Add ContactScreen refresh logic here
          print('Refreshing Contact Screen');
          setState(() {
            // Recreate the screen to trigger refresh
            _screens[3] = RefreshableScreen(
              key: _refreshKeys[3],
              child: const ContactScreen(),
              onRefresh: () async {
                print('Refreshing Contact Screen');
                await Future.delayed(const Duration(seconds: 1));
              },
            );
          });
          await Future.delayed(const Duration(seconds: 1));
        },
      ),
    ];
  }

  void _refreshCurrentScreen() {
    // Trigger the refresh indicator
    _refreshKeys[_currentIndex]?.currentState?.refresh();
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
    // Handle search based on current screen
    switch (_currentIndex) {
      case 0:
        print('Searching Labels: $query');
        break;
      case 1:
        print('Searching Artists: $query');
        // Artists screen will handle its own search
        break;
      case 2:
        print('Searching Distribution: $query');
        break;
      case 3:
        print('Searching Contact: $query');
        break;
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
                    // Search field with white background and black text
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
                                color: Colors.black, // Black text for visibility
                                fontSize: 14.sp,
                              ),
                              decoration: InputDecoration(
                                hintText: _getSearchHint(),
                                hintStyle: TextStyle(
                                  color: Colors.grey[600], // Grey hint text
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
                    // Logo/Image centered
                      Expanded(
                        child: Center(
                          child: Image.asset(
                            'assets/images/splash.jpg',
                            height: 40.h,
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

                    // Action buttons - only show when search is not active
                    if (!_showSearchField)
                      Row(
                        children: [
                          // Search icon
                          IconButton(
                            icon: const Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            onPressed: _toggleSearchField,
                            tooltip: 'Search',
                          ),
                          SizedBox(width: 4.w),
                          // Refresh icon button
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
                // Close search if open when switching screens
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

// Refreshable Screen Wrapper Widget
class RefreshableScreen extends StatefulWidget {
  final Widget child;
  final Future<void> Function() onRefresh;

  const RefreshableScreen({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  RefreshableScreenState createState() => RefreshableScreenState();
}

class RefreshableScreenState extends State<RefreshableScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  void refresh() {
    _refreshIndicatorKey.currentState?.show();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: widget.onRefresh,
      color: AppTheme.lightTheme.primaryColor,
      backgroundColor: Colors.black,
      child: widget.child,
    );
  }
}
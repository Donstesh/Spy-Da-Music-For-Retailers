import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool showLogo;
  final bool showSearch;
  final bool showMenu;
  final VoidCallback? onMenuPressed;
  final ValueChanged<String>? onSearchChanged;
  final String searchHint;
  final Widget? leading;
  final List<Widget>? actions;
  final Color backgroundColor;
  final bool centerTitle;

  const CustomAppBar({
    super.key,
    this.title = '',
    this.showLogo = true,
    this.showSearch = false,
    this.showMenu = true,
    this.onMenuPressed,
    this.onSearchChanged,
    this.searchHint = 'Search...',
    this.leading,
    this.actions,
    this.backgroundColor = Colors.black,
    this.centerTitle = false,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + (showSearch ? 40.h : 0));

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  // Helper methods for responsive design
  bool get _isTablet {
    final mediaQuery = MediaQuery.of(context);
    return mediaQuery.size.shortestSide > 600;
  }

  bool get _isLandscape {
    final mediaQuery = MediaQuery.of(context);
    return mediaQuery.orientation == Orientation.landscape;
  }

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.removeListener(_onFocusChange);
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!_searchFocusNode.hasFocus && _searchController.text.isEmpty) {
      setState(() {
        _isSearching = false;
      });
    }
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (_isSearching) {
        _searchFocusNode.requestFocus();
      } else {
        _searchController.clear();
        _searchFocusNode.unfocus();
        if (widget.onSearchChanged != null) {
          widget.onSearchChanged!('');
        }
      }
    });
  }

  void _onSearchChanged(String value) {
    if (widget.onSearchChanged != null) {
      widget.onSearchChanged!(value);
    }
  }

  void _onClearSearch() {
    _searchController.clear();
    if (widget.onSearchChanged != null) {
      widget.onSearchChanged!('');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeTabletLandscape = _isTablet && _isLandscape && screenWidth > 1200;
    final isMediumTabletLandscape = _isTablet && _isLandscape && screenWidth > 800;

    return Container(
      color: widget.backgroundColor,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Main AppBar content
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: _isTablet
                    ? (isLargeTabletLandscape
                    ? 32.w
                    : isMediumTabletLandscape
                    ? 28.w
                    : 24.w)
                    : 12.w,
                vertical: 0,
              ),
              child: Row(
                children: [
                  // Menu button
                  if (widget.showMenu)
                    Builder(
                      builder: (context) => IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: _isTablet ? (_isLandscape ? 24.w : 28.w) : 24.w,
                        ),
                        onPressed: widget.onMenuPressed ?? () => Scaffold.of(context).openDrawer(),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(
                          minWidth: _isTablet ? (_isLandscape ? 40.w : 48.w) : 40.w,
                          minHeight: _isTablet ? (_isLandscape ? 40.w : 48.w) : 40.w,
                        ),
                      ),
                    ),
                  if (widget.showMenu) SizedBox(width: _isTablet ? (_isLandscape ? 12.w : 16.w) : 8.w),

                  // Leading widget or space
                  if (widget.leading != null) widget.leading!,
                  if (widget.leading != null) SizedBox(width: _isTablet ? (_isLandscape ? 12.w : 16.w) : 8.w),

                  // Title/Logo/Search area
                  Expanded(
                    child: _isSearching
                        ? _buildSearchField(isLargeTabletLandscape, isMediumTabletLandscape)
                        : widget.showLogo
                        ? Center(
                      child: Container(
                        color: Colors.black,
                        child: Image.asset(
                          'assets/images/splash.jpg',
                          height: _isTablet
                              ? (_isLandscape ? 32.h : 36.h)
                              : 38.h,
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                        : widget.centerTitle
                        ? Center(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: _isTablet ? 20.sp : 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                        : Text(
                      widget.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: _isTablet ? 20.sp : 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Actions
                  if (widget.showSearch)
                    IconButton(
                      icon: Icon(
                        _isSearching ? Icons.close : Icons.search,
                        color: Colors.white,
                        size: _isTablet ? (_isLandscape ? 22.w : 24.w) : 20.w,
                      ),
                      onPressed: _toggleSearch,
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(
                        minWidth: _isTablet ? (_isLandscape ? 40.w : 48.w) : 40.w,
                        minHeight: _isTablet ? (_isLandscape ? 40.w : 48.w) : 40.w,
                      ),
                    ),

                  // Custom actions
                  if (widget.actions != null) ...widget.actions!,
                ],
              ),
            ),

            // Optional search bar below (when expanded)
            if (widget.showSearch && _isSearching) _buildExpandedSearchBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField(bool isLargeTabletLandscape, bool isMediumTabletLandscape) {
    return TextField(
      controller: _searchController,
      focusNode: _searchFocusNode,
      style: TextStyle(
        color: Colors.white,
        fontSize: _isTablet
            ? (_isLandscape ? 16.sp : 18.sp)
            : 14.sp,
      ),
      decoration: InputDecoration(
        hintText: widget.searchHint,
        hintStyle: TextStyle(
          color: Colors.grey[400],
          fontSize: _isTablet
              ? (_isLandscape ? 16.sp : 18.sp)
              : 14.sp,
        ),
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: _isTablet ? 12.h : 8.h,
        ),
        suffixIcon: _searchController.text.isNotEmpty
            ? IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.white,
            size: _isTablet ? 20.sp : 18.sp,
          ),
          onPressed: _onClearSearch,
        )
            : null,
      ),
      onChanged: _onSearchChanged,
    );
  }

  Widget _buildExpandedSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _isTablet ? 24.w : 12.w,
        vertical: 8.h,
      ),
      color: Colors.grey[900],
      child: TextField(
        controller: _searchController,
        focusNode: _searchFocusNode,
        style: TextStyle(
          color: Colors.white,
          fontSize: _isTablet ? 16.sp : 14.sp,
        ),
        decoration: InputDecoration(
          hintText: widget.searchHint,
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: _isTablet ? 14.sp : 12.sp,
          ),
          filled: true,
          fillColor: Colors.grey[800],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey[400],
            size: _isTablet ? 20.sp : 18.sp,
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
            icon: Icon(
              Icons.clear,
              color: Colors.white,
              size: _isTablet ? 20.sp : 18.sp,
            ),
            onPressed: _onClearSearch,
          )
              : null,
        ),
        onChanged: _onSearchChanged,
      ),
    );
  }
}
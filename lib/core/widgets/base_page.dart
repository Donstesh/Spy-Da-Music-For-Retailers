import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_app_bar.dart';
import 'loading_widget.dart';
import 'error_widget.dart';

class BasePage extends StatefulWidget {
  final String title;
  final Widget child;
  final bool isLoading;
  final bool hasError;
  final String? errorMessage;
  final VoidCallback? onRetry;
  final bool showAppBar;
  final bool showLogo;
  final bool showSearch;
  final bool showMenu;
  final VoidCallback? onMenuPressed;
  final ValueChanged<String>? onSearchChanged;
  final String searchHint;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNavigationBar;
  final Color backgroundColor;
  final bool centerTitle;

  const BasePage({
    super.key,
    required this.child,
    this.title = '',
    this.isLoading = false,
    this.hasError = false,
    this.errorMessage,
    this.onRetry,
    this.showAppBar = true,
    this.showLogo = true,
    this.showSearch = false,
    this.showMenu = true,
    this.onMenuPressed,
    this.onSearchChanged,
    this.searchHint = 'Search...',
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
    this.backgroundColor = Colors.white,
    this.centerTitle = false,
  });

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: widget.showAppBar
          ? CustomAppBar(
        title: widget.title,
        showLogo: widget.showLogo,
        showSearch: widget.showSearch,
        showMenu: widget.showMenu,
        onMenuPressed: widget.onMenuPressed,
        onSearchChanged: widget.onSearchChanged,
        searchHint: widget.searchHint,
        backgroundColor: Colors.black,
        centerTitle: widget.centerTitle,
      )
          : null,
      body: _buildBody(),
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      bottomNavigationBar: widget.bottomNavigationBar,
    );
  }

  Widget _buildBody() {
    if (widget.isLoading) {
      return const LoadingWidget();
    }

    if (widget.hasError) {
      return CustomErrorWidget(
        errorMessage: widget.errorMessage ?? 'An error occurred',
        onRetry: widget.onRetry,
      );
    }

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: widget.child,
        ),
      ),
    );
  }
}
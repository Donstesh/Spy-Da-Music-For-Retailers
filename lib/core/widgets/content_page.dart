import 'package:flutter/material.dart';
import 'base_page.dart';

class ContentPage extends StatelessWidget {
  final Future<void> Function()? onRefresh;
  final Widget child;
  final String title;
  final bool showSearch;
  final bool showMenu;
  final ValueChanged<String>? onSearchChanged;
  final bool isLoading;
  final bool hasError;
  final String? errorMessage;
  final VoidCallback? onRetry;

  const ContentPage({
    super.key,
    required this.child,
    this.title = '',
    this.onRefresh,
    this.showSearch = false,
    this.showMenu = true,
    this.onSearchChanged,
    this.isLoading = false,
    this.hasError = false,
    this.errorMessage,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: title,
      child: onRefresh != null
          ? RefreshIndicator(
        onRefresh: onRefresh!,
        child: child,
      )
          : child,
      showSearch: showSearch,
      showMenu: showMenu,
      onSearchChanged: onSearchChanged,
      isLoading: isLoading,
      hasError: hasError,
      errorMessage: errorMessage,
      onRetry: onRetry,
      centerTitle: title.isNotEmpty,
    );
  }
}
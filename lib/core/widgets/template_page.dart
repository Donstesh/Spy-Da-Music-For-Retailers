import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'content_page.dart';

class TemplatePage extends StatelessWidget {
  final String title;
  final Widget child;
  final bool showSearch;
  final bool showMenu;
  final ValueChanged<String>? onSearchChanged;
  final Future<void> Function()? onRefresh;

  const TemplatePage({
    super.key,
    required this.title,
    required this.child,
    this.showSearch = false,
    this.showMenu = true,
    this.onSearchChanged,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return ContentPage(
      title: title,
      child: child,
      showSearch: showSearch,
      showMenu: showMenu,
      onSearchChanged: onSearchChanged,
      onRefresh: onRefresh,
    );
  }
}

// Example usage:
class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  String _searchQuery = '';

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      // Implement search logic here
    });
  }

  Future<void> _refreshData() async {
    // Implement refresh logic here
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return TemplatePage(
      title: 'Example Page',
      showSearch: true,
      onSearchChanged: _onSearchChanged,
      onRefresh: _refreshData,
      child: Column(
        children: [
          Text(
            'Search Query: $_searchQuery',
            style: TextStyle(fontSize: 16.sp),
          ),
          SizedBox(height: 20.h),
          // Your content here
          Container(
            height: 200.h,
            color: Colors.grey[200],
            child: const Center(child: Text('Your Content Here')),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewPlansScreen extends StatefulWidget {
  const ViewPlansScreen({super.key});

  @override
  State<ViewPlansScreen> createState() => _ViewPlansScreenState();
}

class _ViewPlansScreenState extends State<ViewPlansScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    // Initialize webview controller for View Plans page
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              _isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse('https://spy-darecordings.com/retail-packages/'));
  }

  void _refreshWebView() {
    _controller.reload();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // WebView
        WebViewWidget(controller: _controller),

        // Loading indicator
        if (_isLoading)
          Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          ),

        // Refresh button
        if (!_isLoading)
          Positioned(
            bottom: 20.h,
            right: 20.w,
            child: FloatingActionButton.small(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              onPressed: _refreshWebView,
              child: const Icon(Icons.refresh),
            ),
          ),
      ],
    );
  }
}
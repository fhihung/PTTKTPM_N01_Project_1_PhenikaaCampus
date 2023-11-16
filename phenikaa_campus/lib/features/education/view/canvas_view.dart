import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Canvas_View extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const Canvas_View(),
      );

  const Canvas_View({super.key});

  @override
  State<Canvas_View> createState() => _Canvas_ViewState();
}

class _Canvas_ViewState extends State<Canvas_View> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://google.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://canvas.phenikaa-uni.edu.vn/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Canvas'),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
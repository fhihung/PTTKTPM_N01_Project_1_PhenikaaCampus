import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Education_View extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const Education_View(),
      );

  const Education_View({super.key});

  @override
  State<Education_View> createState() => _Education_ViewState();
}

class _Education_ViewState extends State<Education_View> {
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
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://qldtbeta.phenikaa-uni.edu.vn/congsinhvien/index.aspx#lichhoc'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter WebView'),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}

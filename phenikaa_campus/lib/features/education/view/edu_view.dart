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
  final url =
      "https://login.microsoftonline.com/0eff33e2-f755-4d49-aa45-ac5ee4ce2308/oauth2/v2.0/authorize?client_id=5392332e-2635-4e9f-a313-2e8cb0f80056&redirect_uri=https://qldtbeta.phenikaa-uni.edu.vn/congsinhvien/login.aspx&response_mode=form_post&response_type=code&grant_type=authorization_code&scope=%20openid+profile&sso_reload=true";
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
            if (request.url.startsWith('https://google.com')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Education'),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}

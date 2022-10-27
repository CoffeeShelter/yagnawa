import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ComparisonSite extends StatelessWidget {
  const ComparisonSite({
    Key? key,
    required this.productName,
  }) : super(key: key);

  final String productName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl:
            'https://msearch.shopping.naver.com/search/all?query=$productName',
        javascriptMode: JavascriptMode.unrestricted,
        gestureNavigationEnabled: true,
      ),
    );
  }
}

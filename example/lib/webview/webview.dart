import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
class InAppWebViewPage extends StatefulWidget {
  final String url;
  InAppWebViewPage(this.url);
  @override
  _InAppWebViewPageState createState() => new _InAppWebViewPageState();
}

class _InAppWebViewPageState extends State<InAppWebViewPage> {
  InAppWebViewController webView;
  String iframeUrl = "https://www.google.com/";

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

        body: Center(
            child: Container(
              height:MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: InAppWebView(
                initialData: InAppWebViewInitialData(
                    data: """
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Flutter InAppWebView</title>
    </head>
    <body>
        <iframe src="$iframeUrl" width="100%" height="100% frameborder="0" allowfullscreen></iframe>
    </body>
</html>"""
                ),
                // initialHeaders: {},
                // initialOptions: InAppWebViewWidgetOptions(
                //   inAppWebViewOptions: InAppWebViewOptions(
                //     debuggingEnabled: true,
                //   ),
                // ),
                // onWebViewCreated: (InAppWebViewController controller) {
                //   webView = controller;
                // },
                // onLoadStart: (InAppWebViewController controller, String url) {
                //
                // },
                // onLoadStop: (InAppWebViewController controller, String url) {
                //
                // },
              ),
            ))
    );
  }
}
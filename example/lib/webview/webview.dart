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
  String iframeUrl = "https://www.youtube.com/embed/vlkNcHDFnGA";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //     title: Text("InAppWebView")
        // ),
        body: Container(
            child: Column(children: <Widget>[

             /// Container(height: 200,),


              Expanded(
                child: Container(
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
    <body style="height:100vh">
        <iframe src="${widget.url}" width="100%" height="100%" frameborder="0" allowfullscreen></iframe>
    </body>
</html>"""
                    ),
                    initialOptions: InAppWebViewGroupOptions(
                        crossPlatform: InAppWebViewOptions(
                           // debuggingEnabled: true,
                            // set this to true if you are using window.open to open a new window with JavaScript
                            javaScriptCanOpenWindowsAutomatically: true
                        ),
                        android: AndroidInAppWebViewOptions(
                          // on Android you need to set supportMultipleWindows to true,
                          // otherwise the onCreateWindow event won't be called
                            supportMultipleWindows: true
                        )
                    ),
                    onWebViewCreated: (InAppWebViewController controller) {
                    //  _webViewController = controller;
                    },




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
                ),
              ),
            ]))
    );
  }
}
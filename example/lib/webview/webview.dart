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
  double   progress=0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
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
        <iframe src="${iframeUrl}" width="100%" height="100%" frameborder="0" allowfullscreen></iframe>
    </body>
</html>"""
                    ),


                    onUpdateVisitedHistory: (_, Uri uri, __) {
                      // uri containts newly loaded url
                   print("wawwwwwwwwwwwwwwwwwwwwwwwwwwwz");
                    },



          onProgressChanged: (InAppWebViewController controller, int progress) {
                      print(progress);
            setState(() {
              this.progress = progress / 100;
            });
          },

                    initialOptions: InAppWebViewGroupOptions(
                        // crossPlatform: InAppWebViewOptions(
                        //    // debuggingEnabled: true,
                        //     // set this to true if you are using window.open to open a new window with JavaScript
                        //    // javaScriptCanOpenWindowsAutomatically: true
                        // ),
                        // android: AndroidInAppWebViewOptions(
                        //   // on Android you need to set supportMultipleWindows to true,
                        //   // otherwise the onCreateWindow event won't be called
                        //     supportMultipleWindows: true
                        // )
                    ),
                    onWebViewCreated: (InAppWebViewController controller) {
                    //  _webViewController = controller;
                    },

                    onLoadStart: (InAppWebViewController controller, url) {
                      // setState(() {
                      //   _con.url = url;
                      // });
                      if (url == "return_url") {
                        //close the webview
                        //_con.webView.goBack();

                        //navigate to the desired screen with arguments

                      }
                    },
                    onLoadHttpError: (InAppWebViewController controller, Uri url,
                        int statusCode, String description) {
                      print("");
                    },
                    onLoadError: (InAppWebViewController controller, Uri url, int code,
                        String message) {
                      print("");
                    },
                    onLoadStop: (InAppWebViewController controller,  url) async {
print("");
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
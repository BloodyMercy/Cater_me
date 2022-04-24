import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../Providers/order_provider.dart';


class InAppWebViewPage extends StatefulWidget {
  final String url;
  InAppWebViewPage(this.url);
  @override
  _InAppWebViewPageState createState() => new _InAppWebViewPageState();
}

class _InAppWebViewPageState extends State<InAppWebViewPage> {
  //InAppWebViewController webView;
  String iframeUrl = "https://www.youtube.com/embed/vlkNcHDFnGA";
  double   progress=0.0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }
 // InAppWebViewController _webViewController;
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderCaterProvider>(context, listen: true);
    return Scaffold(
        // appBar: AppBar(
        //     title: Text("InAppWebView")
        // ),
        body:  WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,

          onWebViewCreated: (WebViewController webViewController) {
           // _controller.complete(webViewController);
          },
          navigationDelegate: (NavigationRequest request) {
            print(request.url);
            if(request.url.startsWith("https://caterme.azurewebsites.net/pay/success")) {

orderProvider.checkotp=true;

    }

else
  {
    orderProvider.checkotp=false;
    print(" error otp");
  }
              //You can do anything

              //Prevent that url works
             // return NavigationDecision.prevent;

            //Any other url works
            return NavigationDecision.navigate;
          },
        ),
    );
  }
}
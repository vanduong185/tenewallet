//import 'package:flutter/material.dart';
//import 'package:flutter_web_view/flutter_web_view.dart';
//
//class WebViewWidget extends StatefulWidget {
//  final String url;
//
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return new WebViewState(url);
//  }
//
//  //constructor
//  WebViewWidget({Key key, @required this.url}) : super(key: key);
//}
//
//class WebViewState extends State<WebViewWidget> {
//  String url;
//  double progress = 0;
//  FlutterWebView flutterWebView = new FlutterWebView();
//
//  // Constructor
//  WebViewState(String url) {
//    this.url = url;
//  }
//
//
//  @override
//  void dispose() {
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return Column(
//      children: <Widget>[
//        (progress != 1.0)
//            ? new SizedBox(
//          child: LinearProgressIndicator(
//              value: progress,
//              valueColor:
//              new AlwaysStoppedAnimation<Color>(Colors.blue[100]),
//              backgroundColor: Colors.blue[800]),
//          height: 2,
//        )
//            : Container(),
//        Expanded(
//          child: Container(
//            margin: const EdgeInsets.all(0.0),
//            decoration:
//            BoxDecoration(border: Border.all(color: Colors.blueAccent)),
//            child: new InAppWebView(
//              initialUrl: url,
//              initialHeaders: {},
//              initialOptions: {},
//              onWebViewCreated: (InAppWebViewController controller) {
//                webView = controller;
//              },
//              onLoadStart: (InAppWebViewController controller, String url) {
//                setState(() {
//                  // this.url = url;
//                });
//              },
//              onProgressChanged:
//                  (InAppWebViewController controller, int progress) {
//                setState(() {
//                  this.progress = progress / 100;
//                });
//              },
//            ),
//          ),
//        )
//      ],
//    );
//  }
//}

//import 'package:flutter/material.dart';
//import 'package:tenewallet/screens/transaction/WebViewWidget.dart';
//
//class TransactionDetail extends StatefulWidget {
//  final String url;
//
//  //constructor
//  TransactionDetail({Key key, @required this.url}) : super(key: key);
//
//  @override
//  createState() => new TransactionDetailState(this.url);
//}
//
//class TransactionDetailState extends State<TransactionDetail> {
//  String url;
//  Color webViewColor = Colors.blue;
//  Color appViewColor = Colors.blue[700];
//  bool isLoading = false;
//
//  TransactionDetailState(String url) {
//    this.url = url;
//  }
//
//  @override
//  void initState() {
//    super.initState();
//    if (url == '' ) {
//      webViewColor = Colors.blue[700];
//      appViewColor = Colors.blue;
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: new AppBar(),
//        body: Text('') //WebViewWidget(url: url,)
//    );
//  }
//}
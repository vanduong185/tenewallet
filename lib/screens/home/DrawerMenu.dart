import "package:flutter/material.dart";
import 'package:flutter_web_view/flutter_web_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';

import "package:tenewallet/screens/recovery/Recovery.dart";

class DrawerMenu extends StatefulWidget {
  QRReaderController QRCodeController;

  DrawerMenu(this.QRCodeController);

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [const Color(0xFF1980BA), const Color(0xFF4AB7E0)],
                    tileMode: TileMode.repeated)),
            child: Center(
                child: Image.asset(
              "image/tenewallet-logo.png",
              height: 100,
              width: 100,
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color(0xFFC7C7C7),
                                  width: 1
                              )
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.rss_feed,
                                color: Color(0xFF4AB7E0),
                              ),
                            ),
                            Text(
                              "News",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF4AB7E0),
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      //launch("https://bitcoin-news.vn");
                      FlutterWebView flutterWebView = new FlutterWebView();
                      flutterWebView.launch(
                          'https://bitcoin-news.vn',
                          javaScriptEnabled: true,
                          barColor: Color(0xFF4AB7E0),
                          inlineMediaEnabled: true,
                          //tintColor: Colors.white,
                          toolbarActions: [
                            new ToolbarAction("Dismiss", 1),
                            new ToolbarAction("Reload", 2)
                          ],
                      );
                      flutterWebView.onToolbarAction.listen((identifier) {
                        switch (identifier) {
                          case 1:
                            widget.QRCodeController?.startScanning();
                            flutterWebView.dismiss();
                            break;
                          case 2:
                            break;
                        }
                      });
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Color(0xFFC7C7C7),
                                width: 1
                            )
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.star,
                              color: Color(0xFF4AB7E0),
                            ),
                          ),
                          Text(
                            "Rating",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF4AB7E0),
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),

                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color(0xFFC7C7C7),
                                  width: 1
                              )
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.settings_backup_restore,
                                color: Color(0xFF4AB7E0),
                              ),
                            ),
                            Text(
                              "Recovery",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF4AB7E0),
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      widget.QRCodeController?.stopScanning();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Recovery())
                      ).then((_) {
                        widget.QRCodeController?.startScanning();
                      });
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

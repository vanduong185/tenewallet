import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';

class ShowQRCode extends StatefulWidget {
  ScrollController scrollController;

  ShowQRCode(this.scrollController);

  @override
  _ShowQRCodeState createState() => _ShowQRCodeState();
}

class _ShowQRCodeState extends State<ShowQRCode> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 15),
      child: Container(
        width: screenWidth * 0.85,
        decoration: BoxDecoration(
            borderRadius:
            BorderRadius.all(Radius.circular(15)),
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFDEF2F9),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Let's share this QR Code",
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Color(0xFF333333),
                              ),
                            ),
                            Text(
                              "(Tap QR symbol to copy your address)",
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xFF333333),
                                  fontWeight: FontWeight.w300
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: GestureDetector(
                        child: Container(
                          child: new QrImage(
                            data: "myaddress",
                            size: screenWidth*0.6,
                          ),
                        ),
                        onTap: () {
                          Clipboard.setData( new ClipboardData(text: "myaddress"));
                          Fluttertoast.showToast(
                            msg: "Code is coppied to clipboard",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIos: 1,
                            backgroundColor: Color(0xFF4AB7E0),
                            textColor: Color(0xFFFFFFFF),
                            fontSize: 14,
                          );
                        },
                      )
                  ),
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        child: Column(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.longArrowAltRight,
                              color: Color(0xFFC5C5C5),
                            ),
                            Text(
                              "SEND",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFC5C5C5)
                              ),
                            )
                          ],
                        ),
                        onTap: () {
                          widget.scrollController.animateTo(
                              widget.scrollController.offset + screenWidth,
                              curve: Curves.linear,
                              duration: Duration(milliseconds: 200)
                          );
                        },
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Icon(
                          FontAwesomeIcons.shareAltSquare,
                          color: Color(0xFF1980BA),
                          size: 18,
                        ),
                      ),
                      Text(
                        "Share",
                        style: TextStyle(
                          color: Color(0xFF1980BA),
                          fontWeight: FontWeight.w500
                        ),
                      )
                    ],
                    crossAxisAlignment: CrossAxisAlignment.end,
                  ),
                  onTap: () {
                    Share.share('This my address wallet');
                  },
                )
              )
            ],
          )
        ),
      ),
    );
  }
}

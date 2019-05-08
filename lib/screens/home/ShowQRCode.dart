import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';
import 'package:tenewallet/services/BitCoinAPI.dart';
import 'package:tenewallet/screens/Statics.dart';

class ShowQRCode extends StatefulWidget {
  ScrollController scrollController;

  ShowQRCode(this.scrollController);

  @override
  _ShowQRCodeState createState() => _ShowQRCodeState();
}

class _ShowQRCodeState extends State<ShowQRCode> {
  String walletAddress = '';
  @override
  void initState() {
    BitCoinAPI().getWallet().then((onValue) {
        setState(() {
          walletAddress = onValue.address;
          Static.publicAddress = onValue.address;
        });
    });

  }

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
          child: Column(
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
                        data: walletAddress,
                        size: screenWidth*0.6,
                      ),
                    ),
                    onTap: () {
                      BitCoinAPI().getBalance().then((onValue) {
                        setState(() {
                        });
                      });
                      Clipboard.setData( new ClipboardData(text: walletAddress));
                      Fluttertoast.showToast(
                        msg: "Address is coppied to clipboard",
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
                          Icons.share,
                          color: Color(0xFF1980BA),
                        ),
                        Text(
                          "Share",
                          style: TextStyle(
                              color: Color(0xFF1980BA)
                          ),
                        )
                      ],
                    ),
                    onTap: () {
                      Share.share('This my wallet address: ' + walletAddress);
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
      ),
    );
  }
}

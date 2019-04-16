import 'package:flutter/material.dart';
import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:tenewallet/screens/wallet/sending.dart';

class ScanQRCode extends StatefulWidget {
  var crypto;
  QRReaderController QRCodeController;
  ScrollController scrollController;

  ScanQRCode(this.crypto, this.QRCodeController, this.scrollController);

  @override
  _ScanQRCodeState createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
  @override
  void initState() {
    super.initState();
  }

  Widget renderQRScanner() {
    if (widget.QRCodeController != null) {
      if (widget.QRCodeController.value.isInitialized) {
        return AspectRatio(
          aspectRatio: widget.QRCodeController.value.aspectRatio,
          child: new QRReaderPreview(widget.QRCodeController),
        );
      }
      else {
        return Container();
      }
    }
    else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 30),
      child: Stack(
        children: <Widget>[
          Container(
            width: screenWidth * 0.85,
            child: renderQRScanner(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              border: Border.all(color: Colors.white, width: 5)
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            width: screenWidth * 0.85,
            height: 400,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                border: Border.all(color: Colors.white, width: 5)
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          child: Column(
                            children: <Widget>[
                              Icon(FontAwesomeIcons.longArrowAltLeft, color: Color(0xFFC5C5C5)),
                              Text("RECEIVE",
                                style: TextStyle(
                                    color: Color(0xFFC5C5C5),
                                    fontWeight: FontWeight.w500
                                ),
                              )
                            ],
                          ),
                          onTap: () {
                            widget.scrollController.animateTo(
                              widget.scrollController.offset - screenWidth,
                              curve: Curves.linear,
                              duration: Duration(milliseconds: 200)
                            );
                          },
                        ),
                        GestureDetector(
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.info, color: Colors.white),
                              Text("Input",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500
                                )
                              )
                            ],
                          ),
                          onTap: () {
                            widget.QRCodeController?.stopScanning();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SendingPage(widget.crypto))
                            ).then((_){
                              widget.QRCodeController?.startScanning();
                            });
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.end,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
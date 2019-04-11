import 'package:flutter/material.dart';
import 'package:tenewallet/components/background.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'dart:async';
import "package:tenewallet/Wallet/sending.dart";
import 'package:tenewallet/Market/coin_details2.dart';

class MainController2 extends StatefulWidget {
  List<CameraDescription> cameras;

  MainController2(this.cameras);

  @override
  _MainController2State createState() => _MainController2State();
}

class _MainController2State extends State<MainController2> {
  QRReaderController controller;

  var crypto = {"name": "Bitcoin", "amount": "5.00", "recipent_address": null};
  var coin = {
    "name": "BTC",
    "value": "15454421",
    "lastest_price": "4,5562",
    "change": "2.233",
    "trend": "up"
  };

  void onCodeRead(dynamic value) {
    print(value);
  }

  @override
  void initState() {
    super.initState();

    controller = new QRReaderController(
      widget.cameras[0],
      ResolutionPreset.medium,
      [CodeFormat.qr],
      (dynamic value) {
        setState(() {
          crypto["recipent_address"] = value;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SendingPage(crypto, controller))
          );
        });
      }
    );

    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }

      if (mounted) {
        setState(() {});
        controller.startScanning();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller?.dispose();
    super.dispose();
  }

  Widget renderCamera() {
    print(controller.value.isInitialized);
    if (!controller.value.isInitialized) {
      return Text("No camera");
    }

    return new AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: QRReaderPreview(controller),
    );
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print(context);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Background(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              "Tenewallet",
              style: TextStyle(color: Color(0xFFA9DFF1)),
            ),
            centerTitle: true,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Icon(
                  Icons.settings,
                  color: Color(0xFFA9DFF1),
                ),
              )
            ],
            backgroundColor: Colors.transparent,
            bottom: PreferredSize(
              child: Container(
                height: 1,
                color: Color(0xFFA9DFF1),
              ),
            ),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Container(
                    height: 80,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                              color: Color(0xFFF5B300),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Icon(
                                Icons.attach_money,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CoinDetailsPage(coin, controller)));
                          },
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.attach_money,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  Text(
                                    "4000",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 36,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "0.9BTC",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w200),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_up,
                                    size: 18,
                                    color: Color(0xFF8BEB4D),
                                  ),
                                  Text(
                                    "12%",
                                    style: TextStyle(
                                        fontSize: 18, color: Color(0xFF8BEB4D)),
                                  )
                                ],
                                mainAxisAlignment: MainAxisAlignment.start,
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: screenWidth,
                  height: screenHeight * 0.65,
                  child: ListView(
                    children: <Widget>[
                      Padding(
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
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
                                                fontWeight: FontWeight.w300),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 30),
                                  child: Container(
                                    child: new QrImage(
                                      data: "duongdzvcl",
                                      size: 200,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Icon(
                                          Icons.arrow_forward,
                                          color: Color(0xFFC5C5C5),
                                        ),
                                        Text(
                                          "SEND",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFFC5C5C5)),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Icon(
                                          Icons.share,
                                          color: Color(0xFF1980BA),
                                        ),
                                        Text(
                                          "Share",
                                          style: TextStyle(
                                              color: Color(0xFF1980BA)),
                                        )
                                      ],
                                    )
                                  ],
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                )
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0, right: 30),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              width: screenWidth * 0.85,
                              child: AspectRatio(
                                aspectRatio: controller.value.aspectRatio,
                                child: new QRReaderPreview(controller),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  border: Border.all(color: Colors.white, width: 5)
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              width: screenWidth * 0.85,
                              height: screenHeight * 0.65,
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
                                          Column(
                                            children: <Widget>[
                                              Icon(
                                                Icons.arrow_back,
                                                color: Color(0xFFC5C5C5),
                                              ),
                                              Text(
                                                "RECEIVE",
                                                style: TextStyle(
                                                    color: Color(0xFFC5C5C5),
                                                    fontWeight: FontWeight
                                                        .w500),
                                              )
                                            ],
                                          ),
                                          GestureDetector(
                                            child: Column(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.info,
                                                  color: Colors.white,
                                                ),
                                                Text("Input",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                        FontWeight.w500))
                                              ],
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SendingPage(crypto, controller)));
                                            },
                                          )
                                        ],
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                      )
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.end,
                                  ),
                                )
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                    scrollDirection: Axis.horizontal,
                  ),
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          )),
    );
  }
}

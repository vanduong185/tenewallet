import 'package:flutter/material.dart';
import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';

import "package:tenewallet/screens/wallet/sending.dart";
import "package:tenewallet/screens/setting/setting.dart";
import 'package:tenewallet/screens/home/coin_infor.dart';
import 'package:tenewallet/screens/home/show_qrcode.dart';
import 'package:tenewallet/screens/home/scan_qrcode.dart';

import 'package:tenewallet/widgets/background.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var crypto = {"name": "Bitcoin", "amount": "5.00", "recipent_address": null};
  var coin = {
    "name": "BTC",
    "value": "15454421",
    "lastest_price": "4,5562",
    "change": "2.233",
    "trend": "up"
  };

  QRReaderController QRCodeController;
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();

    scrollController = new ScrollController();

    availableCameras().then((list_camera) {
      QRCodeController = new QRReaderController(list_camera[0], ResolutionPreset.medium, [CodeFormat.qr], (dynamic value) {
        crypto["recipent_address"] = value;
        QRCodeController.stopScanning();
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SendingPage(crypto))
        ).then((_) {
          QRCodeController.startScanning();
        });
      });

      QRCodeController.initialize().then((_) {
        if (!mounted)
          return;
        else {
          setState(() {});
          QRCodeController.startScanning();
        }
      });
    });
  }

  @override
  void dispose() {
    print("dispose");
    QRCodeController?.dispose();
    super.dispose();
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
              child: IconButton(
                icon: Icon(Icons.settings, color: Color(0xFFA9DFF1),),
                tooltip: "Settings",
                onPressed: () {
                  QRCodeController.stopScanning();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Setting())
                  ).then((value) {
                    QRCodeController.startScanning();
                  });
                },
              ),
            )
          ],
          backgroundColor: Colors.transparent,
          bottom: PreferredSize(
            child: Container(
              height: 1,
              color: Color(0xFFA9DFF1),
            ),
            preferredSize: null,
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CoinInfor(QRCodeController),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Container(
                  width: screenWidth,
                  height: 400,
                  child: ListView(
                    children: <Widget>[
                      ShowQRCode(scrollController),
                      ScanQRCode(crypto, QRCodeController, scrollController)
                    ],
                    scrollDirection: Axis.horizontal,
                    controller: scrollController,
                  )
                ),
              )
            ]
          )
        )
      )
    );
  }
}

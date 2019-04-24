import 'package:flutter/material.dart';
import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';

import "package:tenewallet/screens/wallet/Sending.dart";
import "package:tenewallet/screens/setting/setting.dart";
import 'package:tenewallet/screens/home/CoinInfo.dart';
import 'package:tenewallet/screens/home/ShowQRCode.dart';
import 'package:tenewallet/screens/home/ScanQRCode.dart';

import 'package:tenewallet/widgets/background.dart';
import 'package:tenewallet/assets/fonts/tene_icon_icons.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var crypto = {"name": "Bitcoin", "balance": "0", "recipent_address": null, "price" : ""};

  QRReaderController QRCodeController;
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();

    scrollController = new ScrollController();

    availableCameras().then((list_camera) {
      QRCodeController = new QRReaderController(
          list_camera[0], ResolutionPreset.medium, [CodeFormat.qr],
          (dynamic value) {
        crypto["recipent_address"] = value;
        QRCodeController.stopScanning();
        Navigator.push(context,
                MaterialPageRoute(builder: (context) => SendingPage(crypto)))
            .then((_) {
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
    QRCodeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // set up the list options
    Widget optionOne = SimpleDialogOption(
      child: const Text('Main Net', style: TextStyle(fontSize: 20),),
      onPressed: () {},
    );
    Widget optionTwo = SimpleDialogOption(
      child: const Text('Test Net', style: TextStyle(fontSize: 20, ),),
      onPressed: () {},
    );

    // set up the SimpleDialog
    SimpleDialog dialog = SimpleDialog(
      title: const Text('Choose NetWork:'),
      children: <Widget>[
        optionOne,
        optionTwo
      ],
    );

    return Background(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(
                "Tenewallet",
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              actions: <Widget>[
//                Padding(
//                  padding: const EdgeInsets.only(right: 15),
//                  child: IconButton(
//                    icon: Icon(Icons.language, color: Colors.white, size: 29,),
//                    tooltip: "NetWork",
//                    onPressed: () {
//                      showDialog(
//                        context: context,
//                        builder: (BuildContext context) {
//                          return dialog;
//                        },
//                      );
//                    },
//                  ),
//                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: IconButton(
                    icon: Icon(Icons.history, color: Colors.white),
                    tooltip: "Settings",
                    onPressed: () {
                      QRCodeController?.stopScanning();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Setting())).then((value) {
                        QRCodeController?.startScanning();
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: IconButton(
                    icon: Icon(TeneIcon.setting, color: Colors.white),
                    tooltip: "Settings",
                    onPressed: () {
                      QRCodeController?.stopScanning();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Setting())).then((value) {
                        QRCodeController?.startScanning();
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
                child: Column(children: <Widget>[
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
                    )),
              )
            ]))));
  }
}

import 'package:flutter/material.dart';
import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

class _HomeState extends State<Home> with WidgetsBindingObserver{
  var crypto = {"name": "Bitcoin", "amount": "5.00", "recipent_address": null};

  String title;
  double screenWidth;
  double screenHeight;

  QRReaderController QRCodeController;
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    title = "Receive";

    scrollController = new ScrollController();

    scrollController.addListener(() {
      if (screenWidth != null && screenHeight != null) {
        if (scrollController.offset >= screenWidth*0.85) {
          setState(() {
            title = "Send";
          });
        }

        if (scrollController.offset <= screenWidth*0.15) {
          setState(() {
            title = "Receive";
          });
        }
      }
    });

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
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      if (state == AppLifecycleState.inactive) {
        QRCodeController?.dispose();
      }

      if (state == AppLifecycleState.resumed) {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
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
                title,
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
                    icon: new SvgPicture.asset(
                      "lib/assets/fonts/svg/setting.svg",
                      color: Color(0xFFA9DFF1)
                    ),
                    tooltip: "Settings",
                    onPressed: () {
                      QRCodeController?.stopScanning();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Setting())).then((value) {
                          QRCodeController?.startScanning();
                        }
                      );
                    }
                  )
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
                  height: screenHeight*0.7,
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
            ]))));
  }
}

import 'package:flutter/material.dart';
import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tenewallet/screens/Statics.dart';
import 'package:tenewallet/screens/market/market.dart';
import 'package:tenewallet/services/network.dart';
import 'package:tenewallet/services/BitCoinAPI.dart';
import 'dart:async';

class CoinInfor extends StatefulWidget {
  QRReaderController QRCodeController;

  CoinInfor(this.QRCodeController);

  @override
  _CoinInforState createState() => _CoinInforState();
}

class _CoinInforState extends State<CoinInfor> with WidgetsBindingObserver, RouteAware {
  var coin = {
    "name": "BTC",
    "currentPrice": "",
    "isUp": false,
    "percentChange": 1.0,
  };

  String balance = '';
  String currentPrice = '';
  bool isLoading;
  List coinPriceSeries;
  bool isUp = false;
  double percentChange;

  doInit() {
    isLoading = true;
    BitCoinAPI().getBalance().then((onValue) {
      setState(() {
        balance = onValue;
        Static.balance = balance;
      });
    });

    Network network = new Network();
    network.getCoin7Days().then((data) {
      setState(() {
        coinPriceSeries = data;

        List<double> b = data.map((e) {
          double x = e["close"];
          return x;
        }).toList();

        currentPrice = b[b.length - 1].toString();
        Static.sBtcPrice = double.parse(currentPrice);
        isLoading = false;
        double start = b[0];
        double end = b[b.length - 1];
        double temp = start - end;
        if (temp < 0) {
          isUp = true;
        } else {
          isUp = false;
        }
        percentChange = (temp.abs() / start * 100).floorToDouble();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    doInit();
    // runs every 1 second
    Timer.periodic(new Duration(seconds: 10), (timer) {
      if (Static.isNeedUpdate) {
        BitCoinAPI().getBalance().then((onValue) {
          setState(() {
            balance = onValue;
            Static.balance = balance;
          });
        });
        Static.isNeedUpdate = false;
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      doInit();
    }
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Container(
        height: 120,
        child: Column(
          children: <Widget>[
            renderCoinInfo(),
            renderCoinSparkline(),
          ],
        ),
      ),
    );
  }

  Widget renderCoinInfo() {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            widget.QRCodeController?.stopScanning();
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Market(coin)))
                .then((_) {
              widget.QRCodeController?.startScanning();
            });
          },
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Icon(
                        Icons.account_balance_wallet,
                        size: 28,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    'Balance: ' + balance + ' ฿',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        )
      ],
    );
  }

  Widget renderCoinSparkline() {
    if (isLoading) {
      return Expanded(
        child: Center(
            child: CircularProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation<Color>(Color(0xFFA9DFF1)))),
      );
    } else {
      return
        GestureDetector(
          onTap: () {
            widget.QRCodeController?.stopScanning();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Market(coin)))
                .then((_) {
              widget.QRCodeController?.startScanning();
            });
          },
          child: Container(
            margin: EdgeInsets.only(right: 25, top: 15),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      Icons.monetization_on,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  'Price: ' + currentPrice + ' \$  ',
                  style: TextStyle(
                      color: Colors.white, fontSize: 21, fontWeight: FontWeight.w300),
                ),
                isUp ? Icon(
                  Icons.trending_up,
                  size: 24,
                  color: Colors.greenAccent,
                ) : Icon(
                  Icons.trending_down,
                  size: 24,
                  color: Colors.redAccent,
                ),
                isUp ? Text(
                  ' ' + percentChange.toString() + '%   ',
                  style: TextStyle(fontSize: 18, color: Colors.greenAccent),
                ) : Text(
                  ' ' + percentChange.toString() + '%   ',
                  style: TextStyle(fontSize: 18, color: Colors.redAccent),
                ),
                Expanded(
                  child: Container(
                    width: 50,
                    height: 50,
                    child: Sparkline(
                      sharpCorners: false,
                      data: coinPriceSeries.map((coinPrice) {
                        double highPrice = double.parse(coinPrice["high"].toString());
                        return highPrice;
                      }).toList(),
                      lineColor: Color(0xFFA9DFF1),
                      pointsMode: PointsMode.all,
                      pointColor: Colors.white,
                    ),
                  ),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          )
        );
    }
  }
}

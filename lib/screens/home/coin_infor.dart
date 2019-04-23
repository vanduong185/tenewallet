import 'package:flutter/material.dart';
import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

import 'package:tenewallet/screens/market/market.dart';
import 'package:tenewallet/services/network.dart';
import 'package:tenewallet/assets/fonts/tene_icon_icons.dart';
import 'package:tenewallet/services/BitCoinAPI.dart';

class CoinInfor extends StatefulWidget {
  QRReaderController QRCodeController;

  CoinInfor(this.QRCodeController);

  @override
  _CoinInforState createState() => _CoinInforState();
}

class _CoinInforState extends State<CoinInfor> {
  var coin = {
    "name": "BTC",
    "value": "15454421",
    "lastest_price": "4,5562",
    "change": "2.233",
    "trend": "up"
  };
  String balance = '???';
  String currentPrice = '???';
  bool isLoading;
  List coinPriceSeries;

  @override
  void initState() {
    super.initState();

    isLoading = true;
    Network network = new Network();
    network.getCoin7Days().then((data) {
      print(data.toString());
      setState(() {
        coinPriceSeries = data;
        List<double> a = data.map((e) {
          double b = e["high"];
          return b;
        }).toList();

        List<double> b = data.map((e) {
          double x = e["close"];
          return x;
        }).toList();

        currentPrice = b[b.length - 1].toString();
        isLoading = false;
      });
    });
    BitCoinAPI().getBalance().then((onValue) {
      setState(() {
        balance = onValue;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                        fontSize: 26,
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
      return Container(
        margin: EdgeInsets.only(right: 25, top: 15),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(
                  Icons.show_chart,
                  size: 24,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              'Price:' + currentPrice + ' \$',
              style: TextStyle(
                  color: Colors.white, fontSize: 22, fontWeight: FontWeight.w200),
            ),
            Icon(
              Icons.keyboard_arrow_up,
              size: 18,
              color: Color(0xFF8BEB4D),
            ),
            Text(
              "12%  ",
              style: TextStyle(fontSize: 18, color: Color(0xFF8BEB4D)),
            ),
            Expanded(
              child: Container(
                width: 150,
                height: 50,
                child: Sparkline(
                  data: coinPriceSeries.map((coinPrice) {
                    double highPrice = coinPrice["high"];
                    return highPrice;
                  }).toList(),
                  lineColor: Color(0xFFA9DFF1),
                  pointsMode: PointsMode.all,
                  pointColor: Colors.white,
                ),
              ),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.start,
        ),
      );
    }
  }
}

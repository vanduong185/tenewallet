import 'package:flutter/material.dart';
import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tenewallet/screens/market/market.dart';
import 'package:tenewallet/services/network.dart';
import 'package:tenewallet/assets/fonts/tene_icon_icons.dart';

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

  bool isLoading;
  List coinPriceSeries;

  @override
  void initState() {
    super.initState();

    isLoading = true;
    Network network = new Network();
    network.getCoin7Days().then((data) {
      //print(data);

      setState(() {
        coinPriceSeries = data;
        List<double> a = data.map((e) {
          double b = e["high"];
          return b;
        }).toList();

        print(a);
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Container(
        height: 80,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: renderCoinInfo(),
            ),
            renderCoinSparkline()
          ],
        ),
      ),
    );
  }

  Widget renderCoinInfo() {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Image.asset("image/bitcoin.png", height: 60),
        ),
        GestureDetector(
          onTap: () {
            widget.QRCodeController?.stopScanning();
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Market(coin))
            ).then((_) {
              widget.QRCodeController?.startScanning();
            });
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
                    style:
                    TextStyle(fontSize: 18, color: Color(0xFF8BEB4D)),
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
    );
  }

  Widget renderCoinSparkline() {
    if (isLoading) {
      return Expanded(
        child: Center(child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFA9DFF1)))
        ),
      );
    }
    else {
      return Expanded(
        child: Center(
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
      );
    }
  }
}

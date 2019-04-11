import 'package:flutter/material.dart';
import "package:charts_flutter/flutter.dart" as charts;
import 'package:http/http.dart' as http;
import 'dart:convert';
import "package:tenewallet/components/background.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';

class CoinDetailsPage extends StatefulWidget {
  var _coin;
  QRReaderController QRCodeController;

  CoinDetailsPage(this._coin, this.QRCodeController);

  @override
  _CoinDetailsPageState createState() => _CoinDetailsPageState(_coin);
}

class _CoinDetailsPageState extends State<CoinDetailsPage> {
  var coin;
//  //String url =
//      "https://min-api.cryptocompare.com/data/histohour?fsym=BTC&tsym=USD&limit=24";

//  String url24h = "https://min-api.cryptocompare.com/data/histohour?fsym=BTC&tsym=USD&limit=24";
//  String urlLW = "https://min-api.cryptocompare.com/data/histoday?fsym=BTC&tsym=USD&limit=7";
//  String urlLM = "https://min-api.cryptocompare.com/data/histoday?fsym=BTC&tsym=USD&limit=30";
//  String urlLY = "https://min-api.cryptocompare.com/data/histoday?fsym=BTC&tsym=USD&limit=365";
//  String urlAll = "https://min-api.cryptocompare.com/data/histoday?fsym=BTC&tsym=USD&limit=2000";

  //String btcUrl = "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC&tsyms=USD";

  var data1;
  var btc_data = {
    "priceUSD": 0.0,
    "marketCapUSD": 0.0,
    "priceChange24H": 0.0,
    "priceChange1H": 0.0,
    "rank": "1",
    "priceChange7D": "0",
  };

  List<TimeSeriesPrice> high_price_data = [];
  List<TimeSeriesPrice> low_price_data = [];

  List<charts.Series<TimeSeriesPrice, DateTime>> seriesList;

  var options = [
    {"title": "24h", "type": "24h", "url": "https://min-api.cryptocompare.com/data/histohour?fsym=BTC&tsym=USD&limit=24"},
    {"title": "Last week", "type": "lw", "url": "https://min-api.cryptocompare.com/data/histoday?fsym=BTC&tsym=USD&limit=7"},
    {"title": "Last month", "type": "lm", "url": "https://min-api.cryptocompare.com/data/histoday?fsym=BTC&tsym=USD&limit=30"},
    {"title": "Last year", "type": "ly", "url": "https://min-api.cryptocompare.com/data/histoday?fsym=BTC&tsym=USD&limit=365"},
    {"title": "All", "type": "all" , "url": "https://min-api.cryptocompare.com/data/histoday?fsym=BTC&tsym=USD&limit=2000"},
  ];

  var selectedOption;

  _CoinDetailsPageState(var coin) {
    this.coin = coin;
  }

  Future<String> getHistoryData(String url) async {
    var response = await http.get(url);

    setState(() {
      high_price_data = [];
      low_price_data = [];

      var tmp = jsonDecode(response.body);

      data1 = tmp["Data"];

      for (var i = 0; i < data1.length; i++) {
        var time =
            new DateTime.fromMillisecondsSinceEpoch(data1[i]["time"] * 1000);

        var high_price = new TimeSeriesPrice(
            new DateTime(time.year, time.month, time.day, time.hour), data1[i]["high"]);
        high_price_data.add(high_price);

        var low_price = new TimeSeriesPrice(
            new DateTime(time.year, time.month, time.day, time.hour), data1[i]["low"]);
        low_price_data.add(low_price);
      }

      seriesList = [
        new charts.Series<TimeSeriesPrice, DateTime>(
            id: 'Prices1',
            colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
            domainFn: (TimeSeriesPrice prices, _) => prices.time,
            measureFn: (TimeSeriesPrice prices, _) => prices.price,
            data: high_price_data),
        new charts.Series<TimeSeriesPrice, DateTime>(
            id: 'Prices2',
            colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
            domainFn: (TimeSeriesPrice prices, _) => prices.time,
            measureFn: (TimeSeriesPrice prices, _) => prices.price,
            data: low_price_data),
      ];


    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    widget.QRCodeController.startScanning();
  }

  @override
  initState() {
    // TODO: implement initState
    super.initState();

    widget.QRCodeController.stopScanning();

    selectedOption = options.first;

    setState(() {
      seriesList = [
        new charts.Series<TimeSeriesPrice, DateTime>(
            id: 'Prices',
            colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
            domainFn: (TimeSeriesPrice prices, _) => prices.time,
            measureFn: (TimeSeriesPrice prices, _) => prices.price,
            data: [new TimeSeriesPrice(new DateTime.now(), 0)]),
      ];
    });

    this.getHistoryData(selectedOption["url"]);

    Firestore.instance.collection("coinlist").snapshots().listen((data) {
      var d = data.documents[0].data;

      setState(() {
        btc_data = data.documents[0].data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
//        width: screenWidth,
//        height: screenHeight,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [const Color(0xFF1980BA), const Color(0xFF4AB7E0)],
              tileMode: TileMode.repeated)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            "Bitcoin market",
            style: TextStyle(color: Color(0xFFA9DFF1)),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Color(0xFFA9DFF1)),
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
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
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
                      Column(
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
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Row(
                  children: options.map((option) {
                    return (
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedOption = option;
                            getHistoryData(selectedOption["url"]);
                          });
                        },
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 3),
                            child: Text(
                              option["title"],
                              style: TextStyle(
                                  color: option["type"] == selectedOption["type"]
                                      ? Color(0xFF1980BA)
                                      : Colors.white,
                                  fontSize: 12),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: option["type"] == selectedOption["type"]
                                  ? Colors.white
                                  : Colors.transparent,
                              border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.all(Radius.circular(2))
                          ),
                        ),
                      )
                    );
                  }).toList(),
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: new charts.TimeSeriesChart(
                      seriesList,
                      animate: true,
                      dateTimeFactory: const charts.LocalDateTimeFactory(),
                      animationDuration: Duration(milliseconds: 500),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text("Market Value", style: TextStyle(color: Color(0xFFA9DFF1), fontSize: 12),),
                                  ),
                                  Text(btc_data["marketCapUSD"].toString(), style: TextStyle(color: Colors.white, fontSize: 12))
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text("Price Change 1H", style: TextStyle(color: Color(0xFFA9DFF1), fontSize: 12),),
                                  ),
                                  Text(btc_data["priceChange1H"].toString(), style: TextStyle(color: Colors.white, fontSize: 12))
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text("Price Change 24H", style: TextStyle(color: Color(0xFFA9DFF1), fontSize: 12),),
                                  ),
                                  Text(btc_data["priceChange24H"].toString(), style: TextStyle(color: Colors.white, fontSize: 12))
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                          )
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),

                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text("Ranking of Market Value", style: TextStyle(color: Color(0xFFA9DFF1), fontSize: 12),),
                                  ),
                                  Text(btc_data["rank"].toString(), style: TextStyle(color: Colors.white, fontSize: 12))
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text("Price Change 7 Days", style: TextStyle(color: Color(0xFFA9DFF1), fontSize: 12),),
                                  ),
                                  Text(btc_data["priceChange7D"].toString(), style: TextStyle(color: Colors.white, fontSize: 12))
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text("Price USD", style: TextStyle(color: Color(0xFFA9DFF1), fontSize: 12),),
                                  ),
                                  Text(btc_data["priceUSD"].toString(), style: TextStyle(color: Colors.white, fontSize: 12))
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                          )
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TimeSeriesPrice {
  final DateTime time;
  final num price;

  TimeSeriesPrice(this.time, this.price);
}

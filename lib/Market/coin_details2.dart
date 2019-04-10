import 'package:flutter/material.dart';
import "package:charts_flutter/flutter.dart" as charts;
import 'package:http/http.dart' as http;
import 'dart:convert';
import "package:tenewallet/components/background.dart";

class CoinDetailsPage extends StatefulWidget {
  var _coin;

  CoinDetailsPage(var coin) {
    this._coin = coin;
  }

  @override
  _CoinDetailsPageState createState() => _CoinDetailsPageState(_coin);
}

class _CoinDetailsPageState extends State<CoinDetailsPage> {
  var coin;
  String url =
      "https://min-api.cryptocompare.com/data/histoday?fsym=BTC&tsym=USD&limit=100";

  String btcUrl = "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC&tsyms=USD";

  var data1;
  var btc_data = {
    "PRICE": 0.0,
    "MKTCAP": 0.0,
    "HIGH24HOUR": 0.0,
    "LOW24HOUR": 0.0,
    "RANK": "1",
    "24TRADEVOL": "0",
    "SUPPLY": 0
  };

  List<TimeSeriesPrice> high_price_data = [];
  List<TimeSeriesPrice> low_price_data = [];

  List<charts.Series<TimeSeriesPrice, DateTime>> seriesList;

  var options = [
    {"title": "24h", "type": "24h"},
    {"title": "Last week", "type": "lw"},
    {"title": "Last month", "type": "lm"},
    {"title": "Last year", "type": "ly"},
    {"title": "All", "type": "all"},
  ];

  var selectedOption;

  _CoinDetailsPageState(var coin) {
    this.coin = coin;
  }

  Future<String> getData() async {
    var response = await http.get(url);
    var response2 = await http.get(btcUrl);

    setState(() {
      var tmp = jsonDecode(response.body);
      var tmp2 = jsonDecode(response2.body);

      data1 = tmp["Data"];

      for (var i = 0; i < data1.length; i++) {
        var time =
            new DateTime.fromMillisecondsSinceEpoch(data1[i]["time"] * 1000);

        var high_price = new TimeSeriesPrice(
            new DateTime(time.year, time.month, time.day), data1[i]["high"]);
        high_price_data.add(high_price);

        var low_price = new TimeSeriesPrice(
            new DateTime(time.year, time.month, time.day), data1[i]["low"]);
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

      tmp2 = tmp2["RAW"]["BTC"]["USD"];
      btc_data["PRICE"] = tmp2["PRICE"];
      btc_data["MKTCAP"] = tmp2["MKTCAP"];
      btc_data["HIGH24HOUR"] = tmp2["HIGH24HOUR"];
      btc_data["LOW24HOUR"] = tmp2["LOW24HOUR"];
      btc_data["SUPPLY"] = tmp2["SUPPLY"];
    });
  }

  @override
  initState() {
    // TODO: implement initState
    super.initState();

    selectedOption = options.last;

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

    this.getData();
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
                    return (Container(
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
                          borderRadius: BorderRadius.all(Radius.circular(2))),
                    ));
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
                                  Text(btc_data["MKTCAP"].toString(), style: TextStyle(color: Colors.white, fontSize: 12))
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
                                    child: Text("Highest Price 24h", style: TextStyle(color: Color(0xFFA9DFF1), fontSize: 12),),
                                  ),
                                  Text(btc_data["HIGH24HOUR"].toString(), style: TextStyle(color: Colors.white, fontSize: 12))
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
                                    child: Text("24h Trading Volume", style: TextStyle(color: Color(0xFFA9DFF1), fontSize: 12),),
                                  ),
                                  Text(btc_data["24TRADEVOL"].toString(), style: TextStyle(color: Colors.white, fontSize: 12))
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
                                  Text(btc_data["RANK"].toString(), style: TextStyle(color: Colors.white, fontSize: 12))
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
                                    child: Text("Lowest Price 24h", style: TextStyle(color: Color(0xFFA9DFF1), fontSize: 12),),
                                  ),
                                  Text(btc_data["LOW24HOUR"].toString(), style: TextStyle(color: Colors.white, fontSize: 12))
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
                                    child: Text("Total Supply", style: TextStyle(color: Color(0xFFA9DFF1), fontSize: 12),),
                                  ),
                                  Text(btc_data["SUPPLY"].toString(), style: TextStyle(color: Colors.white, fontSize: 12))
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

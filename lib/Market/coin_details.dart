import 'package:flutter/material.dart';
import "package:charts_flutter/flutter.dart" as charts;
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  String url = "https://min-api.cryptocompare.com/data/histoday?fsym=BTC&tsym=USD&limit=100";
  var data1;
  List<TimeSeriesPrice> high_price_data = [];
  List<TimeSeriesPrice> low_price_data = [];

  List<charts.Series<TimeSeriesPrice, DateTime>> seriesList;

  _CoinDetailsPageState(var coin) {
    this.coin = coin;
  }

  Future<String> getData() async {
    var response = await http.get(url);

    setState(() {
      var tmp = jsonDecode(response.body);

      data1 = tmp["Data"];

      for (var i=0; i<data1.length; i++) {
        var time = new DateTime.fromMillisecondsSinceEpoch(data1[i]["time"]*1000);

        var high_price = new TimeSeriesPrice(new DateTime(time.year, time.month, time.day), data1[i]["high"]);
        high_price_data.add(high_price);

        var low_price = new TimeSeriesPrice(new DateTime(time.year, time.month, time.day), data1[i]["low"]);
        low_price_data.add(low_price);
      }

      seriesList = [
        new charts.Series<TimeSeriesPrice, DateTime>(
            id: 'Prices1',
            colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
            domainFn: (TimeSeriesPrice prices, _) => prices.time,
            measureFn: (TimeSeriesPrice prices, _) => prices.price,
            data: high_price_data
        ),
        new charts.Series<TimeSeriesPrice, DateTime>(
            id: 'Prices2',
            colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
            domainFn: (TimeSeriesPrice prices, _) => prices.time,
            measureFn: (TimeSeriesPrice prices, _) => prices.price,
            data: low_price_data
        ),
      ];
    });
  }



  @override
  initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      seriesList = [
        new charts.Series<TimeSeriesPrice, DateTime>(
            id: 'Prices',
            colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
            domainFn: (TimeSeriesPrice prices, _) => prices.time,
            measureFn: (TimeSeriesPrice prices, _) => prices.price,
            data: [
              new TimeSeriesPrice(new DateTime.now(), 0)
            ]
        ),
      ];
    });

    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[800],
        title: Text("Details " + coin["name"]),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text("USD " + coin["lastest_price"], style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                    ),
                    Text("+ " + coin["change"] + "%", style: TextStyle( fontSize: 16, color: Colors.black54),)
                  ],
                ),
              ),
              Container(
                height: 400,
                child: new charts.TimeSeriesChart(
                  seriesList,
                  animate: true,
                  dateTimeFactory: const charts.LocalDateTimeFactory(),
                  animationDuration: Duration(milliseconds: 500),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}

class TimeSeriesPrice {
  final DateTime time;
  final num price;

  TimeSeriesPrice(this.time, this.price);
}
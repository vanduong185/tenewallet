import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:tenewallet/models/coin.dart';

class CoinChart extends StatefulWidget {
  Coin coin;

  CoinChart(this.coin);

  @override
  _CoinChartState createState() => _CoinChartState();
}

class _CoinChartState extends State<CoinChart> {
  var options = [
    {"title": "24h", "type": "24h", "url": "https://min-api.cryptocompare.com/data/histohour?fsym=BTC&tsym=USD&limit=24"},
    {"title": "Last week", "type": "lw", "url": "https://min-api.cryptocompare.com/data/histoday?fsym=BTC&tsym=USD&limit=7"},
    {"title": "Last month", "type": "lm", "url": "https://min-api.cryptocompare.com/data/histoday?fsym=BTC&tsym=USD&limit=30"},
    {"title": "Last year", "type": "ly", "url": "https://min-api.cryptocompare.com/data/histoday?fsym=BTC&tsym=USD&limit=365"},
    {"title": "All", "type": "all" , "url": "https://min-api.cryptocompare.com/data/histoday?fsym=BTC&tsym=USD&limit=2000"},
  ];

  var selectedOption;

  List<TimeSeriesPrice> high_price_data = [];
  List<TimeSeriesPrice> low_price_data = [];

  List<charts.Series<TimeSeriesPrice, DateTime>> seriesList;

  var data;
  bool isLoading;

  Future<String> getHistoryData(String url) async {
    setState(() {
      isLoading = true;
    });

    var response = await http.get(url);

    setState(() {
      high_price_data = [];
      low_price_data = [];

      var tmp = jsonDecode(response.body);

      data = tmp["Data"];

      //print(data);

      for (var i = 0; i < data.length; i++) {
        var time = new DateTime.fromMillisecondsSinceEpoch(data[i]["time"] * 1000);

        var high_price = new TimeSeriesPrice(new DateTime(time.year, time.month, time.day, time.hour), data[i]["high"]);
        high_price_data.add(high_price);

        var low_price = new TimeSeriesPrice(new DateTime(time.year, time.month, time.day, time.hour), data[i]["low"]);
        low_price_data.add(low_price);
      }

      seriesList = [
        new charts.Series<TimeSeriesPrice, DateTime>(
          id: 'high_price',
          colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
          domainFn: (TimeSeriesPrice prices, _) => prices.time,
          measureFn: (TimeSeriesPrice prices, _) => prices.price,
          data: high_price_data
        ),
        new charts.Series<TimeSeriesPrice, DateTime>(
          id: 'low_price',
          colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
          domainFn: (TimeSeriesPrice prices, _) => prices.time,
          measureFn: (TimeSeriesPrice prices, _) => prices.price,
          data: low_price_data
        ),
      ];

      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    selectedOption = options.first;
    this.getHistoryData(selectedOption["url"]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                        child: Text(
                          option["title"],
                          style: TextStyle(
                              color: option["type"] == selectedOption["type"] ? Color(0xFF1980BA) : Colors.white, fontSize: 12
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: option["type"] == selectedOption["type"] ? Colors.white : Colors.transparent,
                          border: Border.all(color: Colors.white, width: 1, style: BorderStyle.solid),
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
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Container(
            height: 250,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 20),
              child: isLoading
                ? Center(child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFA9DFF1))
                ))
                : new charts.TimeSeriesChart(
                  seriesList,
                  animate: true,
                  dateTimeFactory: const charts.LocalDateTimeFactory(),
                  animationDuration: Duration(milliseconds: 500),
                ),
            ),
          ),
        )
      ],
    );
  }
}

class TimeSeriesPrice {
  final DateTime time;
  final num price;

  TimeSeriesPrice(this.time, this.price);
}
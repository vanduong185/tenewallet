import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class CoinChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _CoinChartState();
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

  TimeSeriesPrice selectedPoint;

  List<TimeSeriesPrice> price_data = [];
  bool isLoading;

  Future<String> getHistoryData(String url) async {
    setState(() {
      selectedPoint = null;
      isLoading = true;
    });

    var response = await http.get(url);

    setState(() {
      price_data = [];

      var tmp = jsonDecode(response.body);

      var data = tmp["Data"];

      for (var i = 0; i < data.length; i++) {
        var time = new DateTime.fromMillisecondsSinceEpoch(data[i]["time"] * 1000);

        var price = new TimeSeriesPrice(new DateTime(time.year, time.month, time.day, time.hour), data[i]["high"], data[i]["low"]);
        price_data.add(price);
      }

      seriesList = [
        new charts.Series<TimeSeriesPrice, DateTime>(
          id: 'high_price',
          colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
          domainFn: (TimeSeriesPrice prices, _) => prices.time,
          measureFn: (TimeSeriesPrice prices, _) => prices.high_price,
          data: price_data
        ),
        new charts.Series<TimeSeriesPrice, DateTime>(
          id: 'low_price',
          colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
          domainFn: (TimeSeriesPrice prices, _) => prices.time,
          measureFn: (TimeSeriesPrice prices, _) => prices.low_price,
          data: price_data
        ),
      ];

      isLoading = false;
    });
  }

  List<charts.Series<TimeSeriesPrice, DateTime>> seriesList;

  final simpleCurrencyFormatter = charts.BasicNumericTickFormatterSpec.fromNumberFormat(
    new NumberFormat.currency(symbol: "\$", decimalDigits: 0)
  );

  showSelectedPoint(model) {
    var selectedDatum = model.selectedDatum;
    if (selectedDatum.isNotEmpty) {
      var datum = selectedDatum.first.datum;
      setState(() {
        selectedPoint = new TimeSeriesPrice(datum.time, datum.high_price, datum.low_price);
      });
    }
  }

  Widget renderSelectedPoint() {
    if (selectedPoint != null) {
      return Row(
        children: <Widget>[
          Text( selectedOption["type"] == "24h" ?
            new DateFormat.jm().format(selectedPoint.time)  :
            new DateFormat.yMd().format(selectedPoint.time)
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Text("●", style: TextStyle(color: Colors.green),),
              ),
              Text("\$" + selectedPoint.high_price.toString())
            ]
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Text("●", style: TextStyle(color: Colors.red),),
              ),
              Text("\$" + selectedPoint.low_price.toString())
            ]
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      );
    }
    else {
      return Container();
    }
  }

  @override
  void initState() {
    super.initState();

    selectedOption = options[0];
    getHistoryData(selectedOption["url"]);
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
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: isLoading
                ? Center(child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFA9DFF1))
                ))
                : Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        child: renderSelectedPoint(),
                      )
                    ),
                    Container(
                      height: 250,
                      child: new charts.TimeSeriesChart(
                        seriesList,
                        animate: true,
                        dateTimeFactory: const charts.LocalDateTimeFactory(),
                        animationDuration: Duration(milliseconds: 500),
                        primaryMeasureAxis: new charts.NumericAxisSpec(
                          tickFormatterSpec: simpleCurrencyFormatter,
                          tickProviderSpec: new charts.BasicNumericTickProviderSpec(zeroBound: false)
                        ),
                        selectionModels: [new charts.SelectionModelConfig(
                          type: charts.SelectionModelType.info,
                          changedListener: showSelectedPoint
                        )],
                        behaviors: [
                          new charts.SelectNearest(eventTrigger: charts.SelectionTrigger.tapAndDrag, ),
                        ],
                      )
                    ),
                  ],
                ),
            )
          ),
        )
      ],
    );
  }
}

class TimeSeriesPrice {
  final DateTime time;
  final num high_price;
  final num low_price;

  TimeSeriesPrice(this.time, this.high_price, this.low_price);
}
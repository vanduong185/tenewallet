import 'package:flutter/material.dart';
import 'package:tenewallet/screens/market/market.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

class MarketPage extends StatefulWidget {
  @override
  _MarketPageState createState() => new _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  List<Map<String, String>> market = [
    {"name": "BTC", "value": "15454421", "lastest_price": "4,5562", "change": "2.233", "trend": "up"},
    {"name": "ETHER", "value": "1521", "lastest_price": "0.2", "change": "223.3", "trend": "down"},
    {"name": "GAS", "value": "11", "lastest_price": "0.002", "change": "213.3", "trend": "up"}
  ];

  List<TableRow> renderTable () {
    List<TableRow> rows = [
      TableRow(
          children: [
            TableCell(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Text("Coin/\nMarket Value",  textAlign: TextAlign.center, style: TextStyle( fontWeight: FontWeight.w700),),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Text("Lastest price/\nChange", textAlign: TextAlign.center, style: TextStyle( fontWeight: FontWeight.w700)),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Text("Trend", textAlign: TextAlign.center, style: TextStyle( fontWeight: FontWeight.w700)),
              ),
            )
          ],
      ),
    ];

    for (var i=0; i<market.length; i++) {
      TableRow r = TableRow(
          children: [
            TableCell(
              child: GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(market[i]["name"], style: TextStyle( fontWeight: FontWeight.w500),),
                      ),
                      Text(market[i]["value"], style: TextStyle( color: Colors.black54),)
                    ],
                  ),
                ),
                onTap: () {
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(builder: (context) => CoinDetailsPage(market[i]))
//                  );
                },
              )
            ),
            TableCell(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(market[i]["lastest_price"], style: TextStyle( fontWeight: FontWeight.w500)),
                  ),
                  Text(market[i]["change"], style: TextStyle( color: Colors.black54))
                ],
              ),
            ),
            TableCell(
              child: Container(
                height: 40,
                child: Sparkline(
                  data: [1.0, 2.0, 3.0, 1.0, 1.0, 0.0, 1.0, 2.0, 3.0, 2.0, 1.0, 0.0],
                  lineColor: Colors.lightBlue,
                ),
              ),
            )
          ],
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1.0, color: Colors.black54))
        )
      );

      rows.add(r);
    }

    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[800],
        title: Center(
          child: Text("Market"),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: new Column(
          children: <Widget>[
            Table(
              children: renderTable(),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            )
          ],
        )
      ),
    );
  }
}
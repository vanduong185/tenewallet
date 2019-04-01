import 'package:flutter/material.dart';

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

  _CoinDetailsPageState(var coin) {
    this.coin = coin;
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
      body: Padding(
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

          ],
        ),
      ),
    );
  }
}
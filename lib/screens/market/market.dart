import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:tenewallet/screens/market/coin_chart.dart';
import 'package:tenewallet/screens/market/coin_details.dart';
import 'package:tenewallet/screens/market/coin_brief_infor.dart';
import 'package:tenewallet/models/coin.dart';
import "package:tenewallet/widgets/background.dart";

class Market extends StatefulWidget {
  var _coin;

  Market(this._coin);

  @override
  _MarketState createState() => _MarketState();
}

class _MarketState extends State<Market> {
  Coin coin;
  bool isLoading;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  initState() {
    super.initState();

    setState(() {
      isLoading = true;
    });

    Firestore.instance.collection("coinlist").snapshots().listen((data) {
      var doc = data.documents[0].data;
      coin = new Coin();
      setState(() {
        coin.id = doc["id"];
        coin.marketCapUSD = doc["marketCapUSD"];
        coin.img = doc["img"];
        coin.name = doc["name"];
        coin.priceChange1H = doc["priceChange1H"];
        coin.priceChange24H = doc["priceChange24H"];
        coin.priceChange7D = doc["priceChange7D"];
        coin.priceUSD = doc["priceUSD"];
        coin.rank = doc["rank"];
        coin.symbolText = doc["symbolText"];
        coin.volumeUSD = doc["volumeUSD"];

        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _appBar,
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                        child: CoinBriefInfor()),
                    CoinChart(coin),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: CoinDetails(coin))
                  ],
                ),
              ),
      ),
    );
  }
}

final _appBar = AppBar(
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
    preferredSize: null,
  ),
  elevation: 0,
);

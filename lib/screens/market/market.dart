import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:tenewallet/screens/market/coin_chart.dart';
import 'package:tenewallet/screens/market/coin_details.dart';
import 'package:tenewallet/screens/market/coin_brief_infor.dart';
import 'package:tenewallet/screens/setting/Setting.dart';
import 'package:tenewallet/models/CoinInfo.dart';

import "package:tenewallet/widgets/background.dart";
import 'package:tenewallet/assets/fonts/tene_icon_icons.dart';

class Market extends StatefulWidget {
  var _coin;

  Market(this._coin);

  @override
  _MarketState createState() => _MarketState();
}

class _MarketState extends State<Market> {
  Coin coin;
  bool isLoading;

  CoinChart coinChart;

  getData() {
    Firestore.instance.collection("coinlist").snapshots().listen((data) {
      if (data.documents.length > 0) {
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
        });
      }

      setState(() {
        isLoading = false;
      });
    });
  }

  Future<Null> refresh() async {
    setState(() {
    });
    return null;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  initState() {
    super.initState();

    isLoading = true;

    coinChart = new CoinChart();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: renderAppbar(),
        body: RefreshIndicator(
          child: isLoading
              ? Center(child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFA9DFF1))
          ))
              : SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: CoinBriefInfor()),
                coinChart,
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: CoinDetails(coin))
              ],
            ),
          ),
          onRefresh: refresh
        )
      ),
    );
  }

  Widget renderAppbar() {
    return AppBar(
      title: Text(
        "Bitcoin market",
        style: TextStyle(color: Color(0xFFA9DFF1)),
      ),
      centerTitle: true,
      iconTheme: IconThemeData(color: Color(0xFFA9DFF1)),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: IconButton(
            icon: Icon(TeneIcon.setting, color: Color(0xFFA9DFF1)),
            tooltip: "Settings",
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Setting())
              );
            },
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
  }
}

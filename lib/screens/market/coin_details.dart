import 'package:flutter/material.dart';

import 'package:tenewallet/models/CoinInfo.dart';

class CoinDetails extends StatefulWidget {
  Coin _coin;

  CoinDetails(this._coin);

  @override
  _CoinDetailsState createState() => _CoinDetailsState();
}

class _CoinDetailsState extends State<CoinDetails> {
  Coin coin;

  @override
  void initState() {
    super.initState();

    coin = widget._coin;
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text("Price USD", style: TextStyle(color: Color(0xFFA9DFF1), fontSize: 14),),
                      ),
                      Text(coin.priceUSD, style: TextStyle(color: Colors.white, fontSize: 14))
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text("Market Value", style: TextStyle(color: Color(0xFFA9DFF1), fontSize: 14),),
                      ),
                      Text(coin.marketCapUSD, style: TextStyle(color: Colors.white, fontSize: 14))
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text("Ranking of Market Value", style: TextStyle(color: Color(0xFFA9DFF1), fontSize: 14),),
                      ),
                      Text(coin.rank, style: TextStyle(color: Colors.white, fontSize: 14))
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),

          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text("Price Change 1H", style: TextStyle(color: Color(0xFFA9DFF1), fontSize: 14),),
                      ),
                      Text(coin.priceChange1H, style: TextStyle(color: Colors.white, fontSize: 14))
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text("Price Change 24H", style: TextStyle(color: Color(0xFFA9DFF1), fontSize: 14),),
                      ),
                      Text(coin.priceChange24H, style: TextStyle(color: Colors.white, fontSize: 14))
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text("Price Change 7 Days", style: TextStyle(color: Color(0xFFA9DFF1), fontSize: 14),),
                      ),
                      Text(coin.priceChange7D, style: TextStyle(color: Colors.white, fontSize: 14))
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }
}
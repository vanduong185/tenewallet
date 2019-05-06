import 'package:flutter/material.dart';
import 'package:tenewallet/assets/fonts/tene_icon_icons.dart';

import 'package:tenewallet/models/CoinInfo.dart';

class CoinBriefInfor extends StatefulWidget {
  Coin _coin;

  CoinBriefInfor(this._coin);

  _CoinBriefInforState createState() => _CoinBriefInforState();
}

class _CoinBriefInforState extends State<CoinBriefInfor> {
  Widget renderPriceChange(String priceChange) {
    
    double pc = double.parse(priceChange.substring(0, priceChange.length-1));

    return Row(
      children: <Widget>[
        Icon(
          (pc < 0) ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
          size: 18,
          color: (pc < 0) ? Color(0xFFFF6B6B) : Color(0xFF8BEB4D),
        ),
        Text(
          pc.abs().toString() + "%",
          style: TextStyle(
              fontSize: 18,
              color: (pc < 0) ? Color(0xFFFF6B6B) : Color(0xFF8BEB4D)
          ),
        )
      ],
      mainAxisAlignment: MainAxisAlignment.start,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Image.asset("image/bitcoin.png", height: 60),
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
                    widget._coin.priceUSD.substring(1),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.w500),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              renderPriceChange(widget._coin.priceChange1H)
            ],
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
          )
        ],
      ),
    );
  }
}
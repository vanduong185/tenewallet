import 'package:flutter/material.dart';
import 'package:tenewallet/assets/fonts/tene_icon_icons.dart';

class CoinBriefInfor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  TeneIcon.crypto_card___currency,
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
    );
  }
}
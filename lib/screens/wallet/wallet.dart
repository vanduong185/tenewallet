import 'package:flutter/material.dart';
import 'package:tenewallet/screens/wallet/transaction.dart';
import 'package:tenewallet/screens/wallet/sending.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  var cryptos = [
    {
      "name": "Bitcoin",
      "amount": "5.00"
    },
    {
      "name": "Ethereum",
      "amount": "6.00"
    }
  ];

  var token = "12.30";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[800],
        title: Center(
          child: Text("Token"),
        ),
        elevation: 0,
      ),
      body: new Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 20),
              child: Container (
                height: 100,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text(token, style: TextStyle( fontSize: 40, fontWeight: FontWeight.w600, color: Colors.black ),),
                      Text("Multi-coin Wallet 1", style: TextStyle( fontSize: 26, fontWeight: FontWeight.w300, color: Colors.black54 ))
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TransactionPage(cryptos[index]) )
                      );
                    },
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
                        child: Row(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Icon(
                                    Icons.monetization_on,
                                    size: 40,
                                    color: Colors.amber,
                                  ),
                                ),
                                Text(cryptos[index]["name"], style: TextStyle(fontSize: 22),)
                              ],
                            ),
                            Text(cryptos[index]["amount"], style: TextStyle(fontSize: 22, color: Colors.black54),)
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.lightBlue[800], width: 1, style: BorderStyle.solid))
                      ),
                    ),
                  );
                },
                itemCount: cryptos.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
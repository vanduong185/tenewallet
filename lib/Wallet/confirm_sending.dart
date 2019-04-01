import 'package:flutter/material.dart';

class ConfirmSendingPage extends StatefulWidget {
  var _transaction;

  ConfirmSendingPage(var transaction) {
    this._transaction = transaction;
  }

  @override
  _ConfirmSendingPageSate createState() => _ConfirmSendingPageSate(_transaction);
}

class _ConfirmSendingPageSate extends State<ConfirmSendingPage> {
  var transaction;
  var from;
  var to;

  TextEditingController tCtrl = new TextEditingController();

  _ConfirmSendingPageSate(transaction) {
    this.transaction = transaction;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tCtrl.text = transaction["recipent_address"];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[800],
        title: Text("Confirm"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.monetization_on, color: Colors.amber, size: 100),
                      Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            children: <Widget>[
                              Text(transaction["sent_crypto_amount"] + " BTC", style: TextStyle(fontSize: 20),),
                              Text("  (USD 8000)", style: TextStyle(fontSize: 14))
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          )
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text("From")
                        ],
                        mainAxisAlignment: MainAxisAlignment.start,
                      ),
                      TextField(
                        onSubmitted: (text) => {
                          setState(() {
                            this.from = text;
                          })
                        },
                        style: TextStyle(
                            color: Colors.black54
                        ),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                          hintText: "asads2213asdsad343saf34fdghr"
                        ),
                        enabled: false,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text("To")
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                    ),
                    TextField(
                      controller: tCtrl,
                      onSubmitted: (text) => {
                        setState(() {
                          this.to = text;
                        })
                      },
                      style: TextStyle(
                        color: Colors.black54
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                        hintText: transaction["recipent_address"]
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 60),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: <Widget>[
                            Text("Network fee", style: TextStyle(fontSize: 18)),
                            Text("0.000014 BTC", style: TextStyle(fontSize: 18))
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: <Widget>[
                            Text("Max Total", style: TextStyle(fontSize: 18)),
                            Text("8.156 USD", style: TextStyle(fontSize: 18))
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: RaisedButton(
                  child: Text("Confirm"),

                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
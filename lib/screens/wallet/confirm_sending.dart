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
  var amount;

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
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text("Confirm", style: TextStyle(color: Color(0xFF1980BA), fontSize: 20),),
        elevation: 0,
        iconTheme: IconThemeData(
            color: Color(0xFF1980BA)
        ),
        bottom: PreferredSize(
          child: Container(
            height: 1,
            color: Color(0xFF1980BA),
          ), preferredSize: null,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          color: Color(0xFFF5B300),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFFd9d9d9),
                              blurRadius: 10,
                              offset: Offset.zero
                            )
                          ]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Icon(
                            Icons.account_balance_wallet,
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
                            Text(
                              "Balance: 4000 ฿",
                              style: TextStyle(
                                  color: Color(0xFF1980BA),
                                  fontSize: 36,
                                  fontWeight: FontWeight.w300),
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                )
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text("From", style: TextStyle(color: Color(0xFF1980BA), fontSize: 16, fontWeight: FontWeight.w500),)
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
                        Text("To", style: TextStyle(color: Color(0xFF1980BA), fontSize: 16, fontWeight: FontWeight.w500))
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                    ),
                    TextField(
                      controller: tCtrl,
                      enabled: false,
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
                padding: const EdgeInsets.only(top: 60, bottom: 60),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: <Widget>[
                            Text("Network Fee", style: TextStyle(color: Color(0xFF1980BA), fontSize: 18, fontWeight: FontWeight.w400)),
                            Text("0.000014 BTC", style: TextStyle(fontSize: 18, color: Color(0xFF333333)))
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: <Widget>[
                            Text("Amount", style: TextStyle(color: Color(0xFF1980BA), fontSize: 18, fontWeight: FontWeight.w400)),
                            Text(transaction['sent_crypto_amount'] + ' BTC ', style: TextStyle(fontSize: 18, color: Color(0xFF333333), fontFamily: String.fromEnvironment("Montserrat")))
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [const Color(0xFF1980BA), const Color(0xFF4AB7E0)],
                          tileMode: TileMode.repeated
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(25))
                  ),
                  child: Center(
                    child: Text("CONFIRM", style: TextStyle(color: Colors.white, fontSize: 16),),
                  ),
                ),
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
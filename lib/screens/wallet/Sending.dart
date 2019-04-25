import 'package:flutter/material.dart';
import "package:qrcode_reader/qrcode_reader.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tenewallet/screens/wallet/ConfirmSending.dart';
import 'package:tenewallet/services/BitCoinAPI.dart';
import 'package:tenewallet/screens/Statics.dart';

class SendingPage extends StatefulWidget {
  var _crypto;

  SendingPage(this._crypto);

  @override
  _SendingPageState createState() {
    return _SendingPageState(_crypto);
  }
}

class _SendingPageState extends State<SendingPage> {
  var crypto;
  var recipentAddress;
  String sentAmount = '0';

  TextEditingController eCtrl1 = new TextEditingController();
  TextEditingController eCtrl2 = new TextEditingController();

  _SendingPageState(var crypto) {
    this.crypto = crypto;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    eCtrl2.text = '0';
    if (this.crypto["recipent_address"] != null) {
      eCtrl1.text = this.crypto["recipent_address"];
      recipentAddress = this.crypto["recipent_address"];
    }
    BitCoinAPI().getBalanceOffline().then((onValue) {
      setState(() {
        this.crypto["balance"] = onValue;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Input",
          style: TextStyle(color: Color(0xFF1980BA), fontSize: 20),
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF1980BA)),
        bottom: PreferredSize(
          child: Container(
            height: 1,
            color: Color(0xFF1980BA),
          ),
          preferredSize: null,
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              child: Center(
                child: Text(
                  "NEXT",
                  style: TextStyle(
                      color: Color(0xFF1980BA),
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              ),
              onTap: () {
                try {
                  double.parse(sentAmount).toString();
                } catch (err) {
                  Fluttertoast.showToast(
                      msg: "Wrong balance value!!!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIos: 1,
                      fontSize: 18.0);
                  return;
                }
                if (recipentAddress != null && sentAmount != null) {
                  if (double.parse(sentAmount) > double.parse(crypto['balance'])) {
                    Fluttertoast.showToast(
                        msg: "Not enough balance!!!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIos: 1,
                        fontSize: 18.0);
                  } else if (recipentAddress.length > 0) {
                    var transaction = {
                      "recipent_address": recipentAddress,
                      "sent_crypto_amount": sentAmount
                    };

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ConfirmSendingPage(transaction)));
                  }
                } else {
                  Fluttertoast.showToast(
                      msg: "Please enter valid address and amount !!!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIos: 1,
                      fontSize: 18.0);
                }
              },
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            "Recipent address",
                            style: TextStyle(
                                color: Color(0xFF1980BA),
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.start,
                      ),
                      TextField(
                        controller: eCtrl1,
//                      onSubmitted: (text) => {
//                        setState(() {
//                          this.recipent_address = text;
//                        })
//                      },
                        onChanged: (text) {
                          setState(() {
                            this.recipentAddress = text;
                          });
                        },
                        decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              child: Icon(
                                Icons.monetization_on,
                                color: Colors.black54,
                              ),
                              onTap: () {
                                //this.openQrReader();
                              },
                            )),
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
                          Text('Amount',
                              style: TextStyle(
                                  color: Color(0xFF1980BA),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500))
                        ],
                        mainAxisAlignment: MainAxisAlignment.start,
                      ),
                      TextField(
                        controller: eCtrl2,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
//                      onSubmitted: (number) => {
//                        setState(() {
//                          this.sent_crypto_amount = number;
//                        })
//                      },
                        onChanged: (number) {
                          setState(() {
                            sentAmount = number;
//                          if (double.parse(sentAmount) > double.parse(crypto['balance'])) {
//                            eCtrl2.text = this.crypto["balance"].toString();
//                          }
                          });
                        },
                        decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "BTC",
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 14),
                                  )
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                              onTap: () {
                                setState(() {
                                  //eCtrl2.text = crypto["amount"];
                                  //sentAmount = crypto["amount"];
                                });
                              },
                            )),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: <Widget>[
                          Text('Current balance : ',
                              style: TextStyle(
                                  color: Color(0xFF1980BA),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                          Text(crypto['balance'] + ' BTC',
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ))),
              Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: <Widget>[
                          Text('Estimate value : ',
                              style: TextStyle(
                                  color: Color(0xFF1980BA),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                          (sentAmount != null && sentAmount != '') ? Text((double.parse(sentAmount) * Static.sBtcPrice).floorToDouble().toString() + ' \$',
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)) : Text('0 \$',
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                        ],
                      )))
            ],
          ),
        ),
      )
    );
  }
}
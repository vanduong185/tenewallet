import 'package:flutter/material.dart';
import 'package:tenewallet/Wallet/confirm_sending.dart';
import "package:qrcode_reader/qrcode_reader.dart";

class  SendingPage extends StatefulWidget {
  var _crypto;

  SendingPage(var crypto) {
    this._crypto = crypto;
  }

  @override
  _SendingPageState createState() => _SendingPageState(_crypto);
}

class _SendingPageState extends State<SendingPage> {
  var crypto;
  var recipent_address;
  var sent_crypto_amount;

  TextEditingController eCtrl1 = new TextEditingController();
  TextEditingController eCtrl2 = new TextEditingController();

  _SendingPageState(var crypto) {
    this.crypto = crypto;
  }

  openQrReader() {
    Future<String> futureString = new QRCodeReader().setAutoFocusIntervalInMs(200).setForceAutoFocus(true).setTorchEnabled(true).setHandlePermissions(true).setExecuteAfterPermissionGranted(true).scan();
    futureString.then((string) {
      setState(() {
        eCtrl1.text = string;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[800],
        title: Text("Send " + crypto["name"]),
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              child: Center(
                child: Text("NEXT", style: TextStyle( fontSize: 16, fontWeight: FontWeight.w500),),
              ),
              onTap: () {
                if (recipent_address != null && sent_crypto_amount != null) {
                  if (recipent_address.length > 0) {
                    var transaction = {
                      "recipent_address": recipent_address,
                      "sent_crypto_amount": sent_crypto_amount
                    };

                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ConfirmSendingPage(transaction))
                    );
                  }
                }
              },
            ),
          )
        ],
      ),
      body: Padding(
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
                        Text("Recipent address")
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                    ),
                    TextField(
                      controller: eCtrl1,
                      onSubmitted: (text) => {
                        setState(() {
                          this.recipent_address = text;
                        })
                      },
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          child: Icon(Icons.apps, color: Colors.black54,),
                          onTap: () {
                            this.openQrReader();
                          },
                        )
                      ),
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
                        Text(crypto["name"])
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                    ),
                    TextField(
                      controller: eCtrl2,
                      keyboardType: TextInputType.number,
                      onSubmitted: (number) => {
                        setState(() {
                          this.sent_crypto_amount = number;
                        })
                      }
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
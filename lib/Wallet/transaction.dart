import 'package:flutter/material.dart';
import 'package:tenewallet/Wallet/sending.dart';

class TransactionPage1 extends StatelessWidget {
  final crypto;

  const TransactionPage1({Key key, this.crypto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[800],
        title: Text(crypto["name"]),
        elevation: 0,
      ),
      body: Padding(
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
                      child: Text(crypto["amount"], style: TextStyle(fontSize: 20),),
                    )
                  ],
                ),
              ),
            ),
            Row(
              children: <Widget>[
                RaisedButton(
                  child: Container(
                    width: 100,
                    height: 50,
                    child: Center(
                      child: Text("Send", style: TextStyle(color: Colors.lightBlue[800], fontSize: 20),),
                    ),
                  ),
                  color: Colors.white,
                  elevation: 3,
                  onPressed: () {
                    Navigator.pop(context);
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) => SendingPage(crypto))
//                    );
                  },
                ),
                RaisedButton(
                  child: Container(
                    width: 100,
                    height: 50,
                    child: Center(
                      child: Text("Receive", style: TextStyle(color: Colors.lightBlue[800], fontSize: 20),),
                    ),
                  ),
                  color: Colors.white,
                  elevation: 3,
                  onPressed: () {

                  },
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            )
          ],
        ),
      )
    );
  }
}

class TransactionPage extends StatefulWidget {
  var _crypto;

  TransactionPage(var crypto) {
    this._crypto = crypto;
  }

  @override
  _TransactionPageState createState() => _TransactionPageState(_crypto);
}

class _TransactionPageState extends State<TransactionPage> {
  var crypto;

  _TransactionPageState(var crypto) {
    this.crypto = crypto;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue[800],
          title: Text(crypto["name"]),
          elevation: 0,
        ),
        body: Padding(
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
                        child: Text(crypto["amount"], style: TextStyle(fontSize: 20),),
                      )
                    ],
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  RaisedButton(
                    child: Container(
                      width: 100,
                      height: 50,
                      child: Center(
                        child: Text("Send", style: TextStyle(color: Colors.lightBlue[800], fontSize: 20),),
                      ),
                    ),
                    color: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    onPressed: () {
//                      Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) => SendingPage(crypto))
//                      );
                    },
                  ),
                  RaisedButton(
                    child: Container(
                      width: 100,
                      height: 50,
                      child: Center(
                        child: Text("Receive", style: TextStyle(color: Colors.lightBlue[800], fontSize: 20),),
                      ),
                    ),
                    color: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    onPressed: () {

                    },
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 10),
                child: Row(
                children: <Widget>[
                    Text("Receiving address", style: TextStyle( fontSize: 14, fontWeight: FontWeight.w500),)
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (ctx, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: <Widget>[
                          Text("asdsa87sadas98s8dass98da98dgfdg"),
                          Icon(Icons.content_copy)
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                    );
                  },
                  itemCount: 2,
                ),
              ),
            ],
          ),
        )
    );
  }
}
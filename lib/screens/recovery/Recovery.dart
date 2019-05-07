import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:tenewallet/services/network.dart';
import 'package:tenewallet/screens/recovery/Confirm.dart';

class Recovery extends StatefulWidget {
  @override
  _RecoveryState createState() => _RecoveryState();
}

class _RecoveryState extends State<Recovery> {
  List<String> listPhrase;
  Network network;

  @override
  void initState() {
    super.initState();
    listPhrase = [];

    network = new Network();
    network.getWords().then((words) {
      setState(() {
        listPhrase = words;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Text("Recovery Phrase",
                        style: TextStyle(
                          color: Color(0xFF1980BA),
                          fontSize: 26,
                          fontWeight: FontWeight.w500
                        )
                      )
                    ),
                    Text(
                      "Write down or copy these words in the right order and save them somewhere else",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 14,
                        fontWeight: FontWeight.w300
                      )
                    )
                  ]
                ),
              )
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: listPhrase.length == 0
                    ? Center(
                        child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFA9DFF1))
                        )
                    )
                    : Text(
                      listPhrase.join(" "),
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center
                    ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 100),
              child: Center(
                child: GestureDetector(
                  child: Container(
                    height: 30,
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Color(0xFF1980BA)),
                      borderRadius: BorderRadius.all(Radius.circular(15))
                    ),
                    child: Center(
                      child: Text("COPY", style: TextStyle(color: Color(0xFF1980BA), fontSize: 14),),
                    ),
                  ),
                  onTap: () {
                    Clipboard.setData( new ClipboardData(text: listPhrase.join(" ")));
                    Fluttertoast.showToast(
                      msg: "Coppied",
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIos: 1,
                      backgroundColor: Color(0xFF8BEB4D),
                      textColor: Colors.white,
                      fontSize: 14,
                    );
                  },
                ),
              )
            ),

            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                child: Text(
                    "Never share recovery phrase with anyone, store it securely",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic
                    )
                ),
              )
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: GestureDetector(
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
                    child: Text("CONTINUE", style: TextStyle(color: Colors.white, fontSize: 16),),
                  ),
                ),
                onTap: () {
                  if (listPhrase.length > 0) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Confirm(listPhrase.join(" ")))
                    );
                  }
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}

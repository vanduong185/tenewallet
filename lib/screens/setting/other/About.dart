import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text("About", style: TextStyle(color: Color(0xFF1980BA), fontSize: 20),),
            elevation: 0,
            iconTheme: IconThemeData(
                color: Color(0xFF1980BA)
            ),
            bottom: PreferredSize(
              child: Container(
                height: 1,
                color: Color(0xFF1980BA),
              ), preferredSize: null,
            )
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              AboutDialog(
                applicationName: "Tenewallet",
                applicationVersion: "Version 1.0.0",
                applicationLegalese: "",
                applicationIcon: Icon(Icons.account_balance_wallet, color: Color(0xFF1980BA),),
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text("Powered by ", style: TextStyle(color: Colors.black54, fontSize: 12),),
                      GestureDetector(
                        child: Text("Teneocto.io", style: new TextStyle(color: Color(0xFF1980BA)  )),
                        onTap: () {
                          launch("https://teneocto.io");
                        },
                      )
                    ],

                  )
                ],
              ),
            ],
          )
        )
    );
  }
}
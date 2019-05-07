import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Confirm extends StatefulWidget {
  String secret;

  Confirm(this.secret);

  @override
  _ConfirmState createState() => _ConfirmState();
}

class _ConfirmState extends State<Confirm> {
  List<String> listConfirmPhrase;
  List<String> shufflePhrase;
  //List<String> listChosenPhrase;

  @override
  void initState() {
    super.initState();
    listConfirmPhrase = [];
    shufflePhrase = widget.secret.split(" ");
    shufflePhrase.shuffle();
  }

  List<Widget> renderPhrase() {
    return shufflePhrase.map((phrase) {
      return GestureDetector(
        child: Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF1980BA), width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: listConfirmPhrase.indexOf(phrase) < 0 ? Colors.white : Color(0xFF1980BA)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Center(
                  child: Text(
                    phrase,
                    style: TextStyle(color: listConfirmPhrase.indexOf(phrase) < 0 ? Color(0xFF1980BA) : Colors.white),
                  ),
                ),
              ),
            )
          ],
          mainAxisSize: MainAxisSize.min,
        ),
        onTap: () {
          setState(() {
            if (listConfirmPhrase.indexOf(phrase) < 0) {
              listConfirmPhrase.add(phrase);
            }
            else {
              listConfirmPhrase.removeAt(listConfirmPhrase.indexOf(phrase));
            }
          });
        },
      );
    }).toList();
  }

  List<Widget> renderConfirmPhrase() {
    if (listConfirmPhrase.length > 0) {
      return listConfirmPhrase.map((phrase) {
        return Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF1980BA), width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Center(
                  child: Text(phrase, style: TextStyle(color: Color(0xFF1980BA)),),
                ),
              ),
            )
          ],
          mainAxisSize: MainAxisSize.min,
        );
      }).toList();
    }
    else {
      return [Container()];
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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
                                child: Text("Confirm Your Phrase",
                                    style: TextStyle(
                                        color: Color(0xFF1980BA),
                                        fontSize: 26,
                                        fontWeight: FontWeight.w500
                                    )
                                )
                            ),
                            Text(
                                "Please select each phrase in order to make sure it is correct",
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
                    height: 200,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: Colors.black54, width: 1)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Wrap(
                        direction: Axis.horizontal,
                        spacing: 5,
                        runSpacing: 5,
                        children: renderConfirmPhrase()
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 10,
                    runSpacing: 10,
                    children: renderPhrase()
                  )
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
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
                        child: Text("CONFIRM", style: TextStyle(color: Colors.white, fontSize: 16),),
                      ),
                    ),
                    onTap: () {
                      if (listConfirmPhrase.length > 0) {
                        if (listConfirmPhrase.join(" ") == widget.secret) {
                          Fluttertoast.showToast(
                            msg: "Correct",
                            backgroundColor: Color(0xFF8BEB4D),
                            textColor: Colors.white,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos: 1,
                            fontSize: 14
                          );
                        }
                        else {
                          Fluttertoast.showToast(
                              msg: "Incorrect",
                              backgroundColor: Colors.red[400],
                              textColor: Colors.white,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIos: 1,
                              fontSize: 14
                          );
                        }
                      }
                      else {
                        Fluttertoast.showToast(
                            msg: "Please choose these phrase",
                            backgroundColor: Color(0xFF7F8FA6),
                            textColor: Colors.white,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos: 1,
                            fontSize: 14
                        );
                      }
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Center(
                    child: GestureDetector(
                      child: Text("Back", style: TextStyle(color: Color(0xFF707070), fontSize: 16),),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                )
              ],
              //crossAxisAlignment: CrossAxisAlignment.start,
            ),
          )
      )
    );
  }
}
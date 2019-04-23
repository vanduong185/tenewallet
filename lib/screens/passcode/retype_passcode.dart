import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

import 'package:tenewallet/screens/index.dart';
import 'package:tenewallet/models/passcode.dart';

class RetypePin extends StatefulWidget {
  String passcode;

  RetypePin(this.passcode);

  @override
  _RetypePinState createState() => _RetypePinState();
}

class _RetypePinState extends State<RetypePin> {
  TextEditingController et;
  String passcodeRetype;
  bool hasError;

  bool checkPinCode() {
    return (passcodeRetype == widget.passcode);
  }

  Future<bool> setPasscode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Passcode passcode = new Passcode();
    passcode.code = widget.passcode;
    passcode.isActive = true;

    var result = await prefs.setString("tenewallet_passcode", passcode.toString());
    return result;
  }

  @override
  void initState() {
    super.initState();

    et = new TextEditingController();
    hasError = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 60),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Text(
                            "Retype",
                            style: TextStyle(
                                color: Color(0xFF1980BA),
                                fontSize: 26,
                                fontWeight: FontWeight.w500
                            )
                        ),
                      ),
                      Text(
                          "Please input previous Passcode to continue",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xFF333333),
                              fontSize: 14,
                              fontWeight:
                              FontWeight.w300
                          )
                      )
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: PinCodeTextField(
                  autofocus: true,
                  controller: et,
                  hideCharacter: true,
                  highlight: true,
                  highlightColor: Color(0xFF4AB7E0),
                  defaultBorderColor: Color(0xFF707070),
                  hasTextBorderColor: Color(0xFF4AB7E0),
                  maxLength: 4,
                  maskCharacter: "●",
                  hasError: hasError,
                  onDone: (text){
                    setState(() {
                      passcodeRetype = text;
                      hasError = !(passcodeRetype == widget.passcode);
                    });
                  },
                  pinCodeTextFieldLayoutType: PinCodeTextFieldLayoutType.AUTO_ADJUST_WIDTH,
                  wrapAlignment: WrapAlignment.start,
                  pinBoxDecoration: ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                  pinTextStyle: TextStyle(fontSize: 16, color: Color(0xFF1980BA)),
                  pinTextAnimatedSwitcherTransition: ProvidedPinBoxTextAnimation.defaultNoTransition,
                  pinTextAnimatedSwitcherDuration: Duration(milliseconds: 100),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
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
                      child: Text("DONE", style: TextStyle(color: Colors.white, fontSize: 16),),
                    ),
                  ),
                  onTap: () async {
                    if (checkPinCode()) {
                      var result = await setPasscode();
                      if (result == true) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => Index()),
                                (Route<dynamic> route) => false);
                      } else {
                        print("fail");
                      }
                    }
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20),
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
          ),
        ),
      ),
    );
  }
}

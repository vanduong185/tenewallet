import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

import 'package:tenewallet/screens/passcode/retype_passcode.dart';

class CreatePasscode extends StatefulWidget {
  @override
  _CreatePasscodeState createState() => _CreatePasscodeState();
}

class _CreatePasscodeState extends State<CreatePasscode> {
  TextEditingController et;
  String passcode;

  bool checkPinCode() {
    return (passcode != null && passcode.length == 4);
  }

  @override
  void initState() {
    super.initState();

    et = new TextEditingController();
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
                          "Create Passcode",
                          style: TextStyle(
                            color: Color(0xFF1980BA),
                            fontSize: 26,
                            fontWeight: FontWeight.w500
                          )
                        ),
                      ),
                      Text(
                        "Please input your Passcode to access TeneWallet",
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
                  hasError: false,
                  onDone: (text){
                    setState(() {
                      passcode = text;
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
                      child: Text("CONTINUE", style: TextStyle(color: Colors.white, fontSize: 16),),
                    ),
                  ),
                  onTap: () {
                    if (checkPinCode()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RetypePin(passcode))
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

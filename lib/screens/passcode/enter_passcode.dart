import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'dart:math';

import 'package:tenewallet/screens/index.dart';

class EnterPasscode extends StatefulWidget {
  String passcode;

  EnterPasscode(this.passcode);

  @override
  State<StatefulWidget> createState() => _EnterPasscodeState();
}

class _EnterPasscodeState extends State<EnterPasscode> {
  PinCodeTextField pinCodeTextField;
  PinCodeTextField pinCodeTextField2;
  //TextEditingController et;
  bool hasError;
  int counter;
  var rng;

  @override
  void initState() {
    super.initState();
    hasError = false;
    counter = 0;

    rng = new Random();

    pinCodeTextField = new PinCodeTextField(
      key: Key(counter.toString()),
      autofocus: true,
      controller: new TextEditingController(),
      hideCharacter: true,
      highlight: true,
      highlightColor: Color(0xFF4AB7E0),
      defaultBorderColor: Color(0xFF707070),
      hasTextBorderColor: Color(0xFF4AB7E0),
      maxLength: 4,
      maskCharacter: "●",
      hasError: false,
      onDone: (text){
        if (text == widget.passcode) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Index())
          );
        }
        else {
          setState(() {
            hasError = true;
          });
        }
      },
      pinCodeTextFieldLayoutType: PinCodeTextFieldLayoutType.AUTO_ADJUST_WIDTH,
      wrapAlignment: WrapAlignment.start,
      pinBoxDecoration: ProvidedPinBoxDecoration.defaultPinBoxDecoration,
      pinTextStyle: TextStyle(fontSize: 16, color: Color(0xFF1980BA)),
      pinTextAnimatedSwitcherTransition: ProvidedPinBoxTextAnimation.defaultNoTransition,
      pinTextAnimatedSwitcherDuration: Duration(milliseconds: 100),
    );

    pinCodeTextField2 = new PinCodeTextField(
      autofocus: true,
      controller: new TextEditingController(),
      hideCharacter: true,
      highlight: true,
      highlightColor: Colors.green,
      defaultBorderColor: Colors.green,
      hasTextBorderColor: Colors.green,
      maxLength: 4,
      maskCharacter: "#",
      hasError: false,
      onDone: (text){
        if (text == widget.passcode) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Index())
          );
        }
        else {
          setState(() {
            hasError = true;
          });
        }
      },
      pinCodeTextFieldLayoutType: PinCodeTextFieldLayoutType.AUTO_ADJUST_WIDTH,
      wrapAlignment: WrapAlignment.start,
      pinBoxDecoration: ProvidedPinBoxDecoration.defaultPinBoxDecoration,
      pinTextStyle: TextStyle(fontSize: 16, color: Colors.red),
      pinTextAnimatedSwitcherTransition: ProvidedPinBoxTextAnimation.defaultNoTransition,
      pinTextAnimatedSwitcherDuration: Duration(milliseconds: 100),
    );
  }

  Widget rendernew() {
    String a = rng.nextInt(100).toString();
    if (hasError) {
      return new PinCodeTextField(
        key: Key("dumamaimoira"),
        //autofocus: true,
        controller: new TextEditingController(),
        hideCharacter: true,
        highlight: true,
        highlightColor: Colors.green,
        defaultBorderColor: Colors.green,
        hasTextBorderColor: Colors.green,
        maxLength: 4,
        maskCharacter: "#",
        hasError: false,
        onDone: (text){
          if (text == widget.passcode) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Index())
            );
          }
          else {
            setState(() {
              hasError = true;
            });
          }
        },
        pinCodeTextFieldLayoutType: PinCodeTextFieldLayoutType.AUTO_ADJUST_WIDTH,
        wrapAlignment: WrapAlignment.start,
        pinBoxDecoration: ProvidedPinBoxDecoration.defaultPinBoxDecoration,
        pinTextStyle: TextStyle(fontSize: 16, color: Colors.red),
        pinTextAnimatedSwitcherTransition: ProvidedPinBoxTextAnimation.defaultNoTransition,
        pinTextAnimatedSwitcherDuration: Duration(milliseconds: 100),
      );
    }
    else {
      return pinCodeTextField;
    }
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
                            "Input Passcode",
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
                child: rendernew()
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
                      child: Text("SIGN IN", style: TextStyle(color: Colors.white, fontSize: 16),),
                    ),
                  ),
                  onTap: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenewallet/MainController/main_controller.dart';
import 'package:tenewallet/MainController/main_controller2.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class RetypePinScreen extends StatefulWidget {
  String _created_pin;
  var cameras;

  RetypePinScreen(this._created_pin, this.cameras);

  @override
  _RetypePinScreenState createState() => _RetypePinScreenState(_created_pin);
}

class _RetypePinScreenState extends State<RetypePinScreen> {
  List<TextEditingController> _eCtrls;
  List<String> _pin;
  TextEditingController et = new TextEditingController();
  String pin_code;

  String _created_pin;

  _RetypePinScreenState(this._created_pin);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _eCtrls = List<TextEditingController>(4);
    _pin = List<String>(4);
  }

  bool checkPinCode() {
//    String pin_code = _pin.join();
//    print(pin_code);
    return ( pin_code == _created_pin);
  }

  Future<bool> set_authenticated() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("1");
    //if (prefs.getString("my_pin_code") == null) {
      print("2");
      //Future<bool> result = (await prefs.setString("my_pin_code", _created_pin)) as Future<bool>;
      var result = await prefs.setString("my_pin_code", _created_pin);
      print("3");
      print(result);
      return result;
    //}
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Retype PIN code"),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                child: Center(
                  child: Text("NEXT", style: TextStyle( fontSize: 16, fontWeight: FontWeight.w500),),
                ),
                onTap: () async {
                  if (checkPinCode()) {
//                    Navigator.removeRoute(
//                      context,
//                      MaterialPageRoute(builder: (context) => CreatePinScreen())
//                    );
//
//                    Navigator.pushReplacement(
//                        context,
//                        MaterialPageRoute(builder: (context) => MainController())
//                    );
                    var result = await set_authenticated();
                    print("4");
                    print(result);
                    if (result == true) {
                      print("ok");
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => MainController2(widget.cameras)),
                              (Route<dynamic> route) => false
                      );
                    }
                    else {
                      print("fail");
                    }
                  }
                },
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Text("Retype your PIN code", style: TextStyle( fontSize: 20, fontWeight: FontWeight.w500)),
                ),
                PinCodeTextField(
                  autofocus: true,
                  controller: et,
                  hideCharacter: true,
                  highlight: true,
                  highlightColor: Colors.lightBlue[500],
                  defaultBorderColor: Colors.black,
                  hasTextBorderColor: Colors.lightBlue[500],
                  maxLength: 4,
                  maskCharacter: "●",
                  hasError: false,

                  onDone: (text){
                    setState(() {
                      pin_code = text;
                    });
                  },
                  pinCodeTextFieldLayoutType: PinCodeTextFieldLayoutType.AUTO_ADJUST_WIDTH,
                  wrapAlignment: WrapAlignment.start,
                  pinBoxDecoration: ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                  pinTextStyle: TextStyle(fontSize: 30.0),
                  pinTextAnimatedSwitcherTransition: ProvidedPinBoxTextAnimation.defaultNoTransition,
                  pinTextAnimatedSwitcherDuration: Duration(milliseconds: 100),
                ),
              ],
            ),
          ),
        )
    );
  }

  List<Widget> generateListBlockField() {
    List<Widget> listBlock = [];

    for (var i = 0; i < _pin.length; i++) {
      listBlock.add(BlockField(_eCtrls[i], i));
    }

    return listBlock;
  }

  Widget BlockField(TextEditingController eCtrl, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: 50,
        height: 50,
        child: TextField(
          keyboardType: TextInputType.number,
          maxLength: 1,
          obscureText: true,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            counterText: "",
          ),
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 26,
              color: Colors.lightBlue[800]
          ),
          controller: eCtrl,
          onChanged: (string) {
            setState(() {
              _pin[index] = string;
            });

          } ,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenewallet/MainController/main_controller.dart';
import 'package:tenewallet/MainController/main_controller2.dart';
import "package:flutter/services.dart";
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:tenewallet/MainController/test.dart';

class EnterPinScreen extends StatefulWidget {
  var cameras;

  EnterPinScreen(this.cameras);

  @override
  _EnterPinScreenState createState() => _EnterPinScreenState();
}

class _EnterPinScreenState extends State<EnterPinScreen> {
  List<TextEditingController> _eCtrls;
  List<String> _pin;
  List<FocusNode> _focusNodes;

  String pin_code;

  get_pin_code() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      pin_code = prefs.getString("my_pin_code");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pin = List<String>(4);
    _eCtrls = List<TextEditingController>(4).map((t) => t = new TextEditingController()).toList();
    _focusNodes = List<FocusNode>(4).map((f) => f = new FocusNode()).toList();

    get_pin_code();
  }

  TextEditingController et = new TextEditingController();
  FocusNode fn = new FocusNode();

  handleKey(RawKeyEvent key) {
    print("Event runtimeType is ${key.runtimeType}");
    if(key.runtimeType.toString() == 'RawKeyDownEvent'){
      RawKeyEventDataAndroid data = key.data as RawKeyEventDataAndroid;
      String _keyCode;
      _keyCode = data.keyCode.toString(); //keycode of key event (66 is return)

      print("why does this run twice $_keyCode");
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("PIN code"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Text("Enter pin code", style: TextStyle( fontSize: 20, fontWeight: FontWeight.w500)),
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
                  if (text == pin_code) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MainController2(widget.cameras))
                    );
                  }
                },
                pinCodeTextFieldLayoutType: PinCodeTextFieldLayoutType.AUTO_ADJUST_WIDTH,
                wrapAlignment: WrapAlignment.start,
                pinBoxDecoration: ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                pinTextStyle: TextStyle(fontSize: 30.0),
                pinTextAnimatedSwitcherTransition: ProvidedPinBoxTextAnimation.defaultNoTransition,
                pinTextAnimatedSwitcherDuration: Duration(milliseconds: 100),
              ),
              //KeyboardListener()
            ],
          ),
        ),
      )
    );
  }

  List<Widget> generateListBlockField(BuildContext ctx) {
    List<Widget> listBlock = [];

    for (var i = 0; i < _pin.length; i++) {
      listBlock.add(BlockField(ctx, _eCtrls[i], _focusNodes[i], i));
    }

    return  listBlock;
  }


  Widget BlockField(BuildContext ctx, TextEditingController eCtrl, FocusNode focusNode, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: 50,
        height: 50,
        child: RawKeyboardListener(
          key: Key(index.toString()),
          onKey: (key) => print(key),
          focusNode: focusNode,
          child: TextField(
            keyboardType: TextInputType.number,
            maxLength: 1,
            obscureText: true,
            textAlign: TextAlign.center,
            autofocus: (index == 0),
            decoration: InputDecoration(
              counterText: "",
            ),
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 26,
                color: Colors.lightBlue[800]
            ),
            controller: eCtrl,
            focusNode: focusNode,
            onChanged: (string) {
              setState(() {
                _pin[index] = string;

                String pin_code1 = _pin.join();

                if (pin_code1 == pin_code) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MainController())
                  );
                }

                if (index < 3 && string.length > 0) {
                  FocusScope.of(ctx).requestFocus(_focusNodes[index + 1]);
                }

                if (string.isEmpty && index > 0) {
                  FocusScope.of(ctx).requestFocus(_focusNodes[index - 1]);
                }
              });
            },
          ),
        ),
      ),
    );
  }
}

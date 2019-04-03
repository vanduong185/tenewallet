import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenewallet/Authentication/retype_pin_code.dart';

class CreatePinScreen extends StatefulWidget {
  @override
  _CreatePinScreenState createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {
  List<TextEditingController> _eCtrls;
  List<String> _pin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _eCtrls = List<TextEditingController>(4);
    _pin = List<String>(4);
  }

  bool checkPinCode() {
    String pin_code = _pin.join();
    print(pin_code);
    return ( _pin.indexOf(null) < 0 && pin_code.length == 4);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Create PIN code"),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                child: Center(
                  child: Text("NEXT", style: TextStyle( fontSize: 16, fontWeight: FontWeight.w500),),
                ),
                onTap: () {
                  if (checkPinCode()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RetypePinScreen(_pin.join()))
                    );
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
                  child: Text("Create your PIN code", style: TextStyle( fontSize: 20, fontWeight: FontWeight.w500)),
                ),
                Row(
                  children: generateListBlockField(),
                  mainAxisAlignment: MainAxisAlignment.center,
                )
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

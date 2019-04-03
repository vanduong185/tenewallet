import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenewallet/MainController/main_controller.dart';

class EnterPinScreen extends StatefulWidget {
  @override
  _EnterPinScreenState createState() => _EnterPinScreenState();
}

class _EnterPinScreenState extends State<EnterPinScreen> {
  List<TextEditingController> _eCtrls;
  List<String> _pin;
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

    _eCtrls = List<TextEditingController>(4);
    _pin = List<String>(4);

    get_pin_code();
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

    return  listBlock;
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
            print(string);

            setState(() {
              _pin[index] = string;

              String pin_code1 = _pin.join();

              if (pin_code1 == pin_code) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (contex) => MainController())
                );
              }
            });

          } ,
        ),
      ),
    );
  }
}

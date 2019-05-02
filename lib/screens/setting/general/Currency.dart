import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Currency extends StatefulWidget {
  @override
  _CurrencyState createState() => _CurrencyState();
}

class _CurrencyState extends State<Currency> {
  String selectedCurrency;

  @override
  void initState() {
    super.initState();
    selectedCurrency = "BTC";
  }

  Future<bool> showCurrencyList(context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return CurrencyDialog(selectedCurrency);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Color(0xFFC7C7C7), width: 1))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: <Widget>[
            GestureDetector(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: new SvgPicture.asset(
                        "lib/assets/fonts/svg/currency.svg",
                        color: Color(0xFF4AB7E0)),
                  ),
                  Text(
                    "Currency",
                    style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 14,
                        fontWeight: FontWeight.w300),
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
              onTap: () {
                showCurrencyList(context);
              },
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
    );
  }
}

class CurrencyDialog extends StatefulWidget {
  String selectedCurrency;

  CurrencyDialog(this.selectedCurrency);

  @override
  _CurrencyDialogState createState() => _CurrencyDialogState();
}

class _CurrencyDialogState extends State<CurrencyDialog> {
  String selectedCurrency;

  @override
  void initState() {
    super.initState();
    selectedCurrency = widget.selectedCurrency;
  }

  void onChangeCurrency(String value) {
    setState(() {
      selectedCurrency = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 5,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Radio(
                    value: "USD",
                    groupValue: selectedCurrency,
                    onChanged: onChangeCurrency,
                    activeColor: Color(0xFF1980BA),
                  ),
                  Text(
                    "USD",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: "JPY",
                    groupValue: selectedCurrency,
                    onChanged: onChangeCurrency,
                    activeColor: Color(0xFF1980BA),
                  ),
                  Text("JPY", style: TextStyle(fontSize: 16))
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: "BTC",
                    groupValue: selectedCurrency,
                    onChanged: onChangeCurrency,
                    activeColor: Color(0xFF1980BA),
                  ),
                  Text("BTC", style: TextStyle(fontSize: 16))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Network extends StatefulWidget {
  @override
  _NetworkState createState() => _NetworkState();
}

class _NetworkState extends State<Network> {
  String selectedNetwork;

  @override
  void initState() {
    super.initState();
    selectedNetwork = "testnet";
  }

  Future<bool> showNetworkList(context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return NetworkDialog(selectedNetwork);
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
                      child: Icon(
                        Icons.explore,
                        color: Color(0xFF4AB7E0),
                        size: 18,
                      )),
                  Text(
                    "Network",
                    style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 14,
                        fontWeight: FontWeight.w300),
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
              onTap: () {
                showNetworkList(context);
              },
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
    );
  }
}

class NetworkDialog extends StatefulWidget {
  String selectedNetwork;

  NetworkDialog(this.selectedNetwork);

  @override
  _NetworkDialogState createState() => _NetworkDialogState();
}

class _NetworkDialogState extends State<NetworkDialog> {
  String selectedNetwork;

  @override
  void initState() {
    super.initState();
    selectedNetwork = widget.selectedNetwork;
  }

  void onChangeNetwork(String value) {
    setState(() {
      selectedNetwork = value;
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
                    value: "mainnet",
                    groupValue: selectedNetwork,
                    onChanged: onChangeNetwork,
                    activeColor: Color(0xFF1980BA),
                  ),
                  Text(
                    "Main network",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: "testnet",
                    groupValue: selectedNetwork,
                    onChanged: onChangeNetwork,
                    activeColor: Color(0xFF1980BA),
                  ),
                  Text("Test network", style: TextStyle(fontSize: 16))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

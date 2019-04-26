import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_flutter/src/models/networks.dart' as NETWORKS;
import 'package:bip39/bip39.dart' as bip39;
import 'package:bitcoin_flutter/src/payments/p2pkh.dart' show P2PKH, P2PKHData;
import 'package:tenewallet/models/BitWalletInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tenewallet/config/AppConfig.dart';
import 'dart:convert';
import 'dart:core';
import 'package:flutter_web_view/flutter_web_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tenewallet/screens/Statics.dart';
import 'package:random_string/random_string.dart';


class BitCoinAPI {
  rng(int number) {
    return utf8.encode(randomString(32));
  }

  //**
  // * Generate BTC testnet address
  // */
  BitWalletInfo generateTestNetAddress() {
    final testnet = NETWORKS.testnet;
    final keyPair = ECPair.makeRandom(network: testnet, rng: rng);
    final wif = keyPair.toWIF();
    final address = new P2PKH(
            data: new P2PKHData(pubkey: keyPair.publicKey), network: testnet)
        .data
        .address;
    return new BitWalletInfo(wif, address);
  }

  /*
   * Import BTC wallet from WIF
   */
  BitWalletInfo importFromWIF(String wif) {
    try {
      final keyPair = ECPair.fromWIF(wif);
      final address = new P2PKH(data: new P2PKHData(pubkey: keyPair.publicKey))
          .data
          .address;
      return new BitWalletInfo(wif, address);
    } catch (err) {
      return null;
    }
  }

  /*
   * Generate random BTC address
   */
  BitWalletInfo generateRandomAddress() {
    final keyPair = ECPair.makeRandom(rng: rng);
    final address =
        new P2PKH(data: new P2PKHData(pubkey: keyPair.publicKey)).data.address;
    return new BitWalletInfo(keyPair.toWIF(), address);
  }

  /*
   * Get TestNet BTC address
   */
  Future<BitWalletInfo> getWallet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String address = prefs.getString('btc_wallet');
    String wif = prefs.getString('btc_wif');
    if (address == null || address == '' || wif == null) {
      BitWalletInfo walletInfo = generateTestNetAddress();
      prefs.setString('btc_wallet', walletInfo.address);
      prefs.setString('btc_wif', walletInfo.wif);
      return new BitWalletInfo(
          walletInfo.wif,
          walletInfo.address);
    } else {
      return new BitWalletInfo(wif, address);
    }
  }

  Future<String> getBalance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    BitWalletInfo wallet = await getWallet();
    print(wallet.address);
    String requestURL =
        AppConfig.BTC_TEST_NET3 + '/addrs/' + wallet.address + '/balance';
    final response = await http.get(requestURL);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print('Balance: ' + (result['balance'] / 100000000).toString());
      prefs.setString(
          'last_balance', (result['balance'] / 100000000).toString());
      return (result['balance'] / 100000000).toString();
    } else {
      return prefs.getString('last_balance');
    }
  }

  Future<String> getBalanceOffline() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('last_balance');
  }

  Future<String> createTransaction(
      BuildContext context, String recipent, double amount) async {
    BitWalletInfo wallet = await getWallet();
    var newtx = {
      "inputs": [
        {
          "addresses": [wallet.address]
        }
      ],
      "outputs": [
        {
          "addresses": [recipent],
          "value": (amount * 100000000).round()
        }
      ]
    };
    print(AppConfig.BTC_TEST_NET3 + '/addrs/' + wallet.address);

    http
        .get(AppConfig.BTC_TEST_NET3 + '/addrs/' + wallet.address)
        .then((http.Response response) {
      var resultAddr = json.decode(response.body);
      http
          .post(AppConfig.BTC_TEST_NET3 + '/txs/new', body: json.encode(newtx))
          .then((http.Response response) {
        print(response.body);
        try {
          var tx = jsonDecode(response.body);
          final sender = ECPair.fromWIF(wallet.wif, network: NETWORKS.testnet);
          final txb = new TransactionBuilder(network: NETWORKS.testnet);
          print(resultAddr['txrefs'][0]['tx_output_n']);
          txb.setVersion(2);
          //txb.addInput(resultAddr['txrefs'][0]['tx_hash'], resultAddr['txrefs'][0]['tx_output_n']);

          txb.addInput(tx['tx']['inputs'][0]['prev_hash'],
              tx['tx']['inputs'][0]['output_index']);
          txb.addOutput(recipent, (amount * 100000000).round());

          txb.sign(0, sender);
          String transactionHex = txb.build().toHex();
          print(transactionHex);
          var pushtx = {'tx': transactionHex};
          http
              .post(AppConfig.BTC_TEST_NET3 + '/txs/push',
                  body: json.encode(pushtx))
              .then((http.Response res) {
            var txResult = json.decode(res.body);
            print(txResult);
            Static.isNeedUpdate = true;
            Navigator.pop(context);
            FlutterWebView flutterWebView = new FlutterWebView();
            flutterWebView.launch(
                'https://live.blockcypher.com/btc-testnet/tx/' +
                    txResult['tx']['hash'],
                javaScriptEnabled: false,
                toolbarActions: [
                  new ToolbarAction("Dismiss", 1),
                ],
                barColor: Colors.green,
                tintColor: Colors.white);
            flutterWebView.onToolbarAction.listen((identifier) {
              switch (identifier) {
                case 1:
                  flutterWebView.dismiss();
                  break;
                case 2:
                  break;
              }
            });
          });
        } catch (err) {
          Navigator.pop(context);
          Fluttertoast.showToast(
              msg:
                  "An error happend , please make sure you have enough balance !!!",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              fontSize: 16.0);
        }
      });
    });
  }
}

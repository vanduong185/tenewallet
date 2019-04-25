import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:bitcoin_flutter/src/models/networks.dart' as NETWORKS;
import 'package:bip39/bip39.dart' as bip39;
import 'package:bitcoin_flutter/src/payments/p2pkh.dart' show P2PKH, P2PKHData;
import 'package:tenewallet/models/BitWalletInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tenewallet/config/AppConfig.dart';
import 'dart:convert';
import 'dart:core';

class BitCoinAPI {

  rng(int number) {
    return 1;
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
    String secret = prefs.getString('btc_secret');
    if (address == null || address == '' || secret == null) {
      prefs.setString('btc_wallet', 'mkHS9ne12qx9pS9VojpwU5xtRd4T7X7ZUt');
      prefs.setString(
          'btc_secret', 'cRgnQe9MUu1JznntrLaoQpB476M8PURvXVQB5R2eqms5tXnzNsrr');
      return new BitWalletInfo(
          'cRgnQe9MUu1JznntrLaoQpB476M8PURvXVQB5R2eqms5tXnzNsrr',
          'mkHS9ne12qx9pS9VojpwU5xtRd4T7X7ZUt');
    } else {
      return new BitWalletInfo(secret, address);
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
      prefs.setString('last_balance', (result['balance'] / 100000000).toString());
      return (result['balance'] / 100000000).toString() ;
    } else {
      return prefs.getString('last_balance');
    }
  }

}

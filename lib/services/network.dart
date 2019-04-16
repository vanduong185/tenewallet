import 'package:http/http.dart' as http;
import 'dart:convert';

class Network {
  String COIN_7D_URL = "https://min-api.cryptocompare.com/data/histoday?fsym=BTC&tsym=USD&limit=7";

  Future<List> getCoin7Days() async{
    var response = await http.get(COIN_7D_URL);
    var tmp = jsonDecode(response.body);
    var data = tmp["Data"];
    return data;
  }
}
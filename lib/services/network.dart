import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

class Network {
  String COIN_7D_URL = "https://min-api.cryptocompare.com/data/histoday?fsym=BTC&tsym=USD&limit=7";
  String WORD_COUNT_URL = "http://www.wordcount.org/dbquery.php?method=SEARCH_BY_INDEX&toFind=";

  Future<List> getCoin7Days() async{
    var response = await http.get(COIN_7D_URL);
    var tmp = jsonDecode(response.body);
    var data = tmp["Data"];
    return data;
  }

  Future<List> getWords() async {
    List<String> words = [];
    var ran = new Random();
    var index = ran.nextInt(8000);

    var response = await http.get(WORD_COUNT_URL + index.toString());
    String data = response.body;

    var array = data.split("&word");

    for (int i = 2; i < 14; i++) {
      var tmp = array[i].split("&freq");
      String word = tmp[0].split("=").last;
      words.add(word);
    }

    return words;
  }
}
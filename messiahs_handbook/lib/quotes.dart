import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math';

class QuotesRepository {
  final List<String> _quotes = new List();
  static final Random _randomizer = Random.secure();

  Future<List<String>> fetchQuotes() async {
    http.Response response = await http.get(
        'https://raw.githubusercontent.com/medvedovo/messiahs-handbook/master/messiahs_handbook/quotes.json');
    List responseJson = json.decode(response.body);
    return responseJson.map((m) => m.toString()).toList();
  }

  Future<String> getRandomQuote() async {
    String result;
    if (_quotes.isEmpty) {
      await fetchQuotes().then((data) {
        _quotes.addAll(data);
        result = _quotes[_randomizer.nextInt(_quotes.length)];
      });
    } else {
      result = _quotes[_randomizer.nextInt(_quotes.length)];
    }
    return result;
  }
}

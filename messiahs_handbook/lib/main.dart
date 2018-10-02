import 'package:flutter/material.dart';
import 'quotes.dart';
import 'package:share/share.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Карманный справочник Мессии',
      theme: new ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: new MessiahsHandbookQuote(),
    );
  }
}

class MessiahsHandbookQuote extends StatefulWidget {
  MessiahsHandbookQuote({Key key}) : super(key: key);

  @override
  _MessiahsHandbookQuoteState createState() =>
      new _MessiahsHandbookQuoteState();
}

class _MessiahsHandbookQuoteState extends State<MessiahsHandbookQuote> {
  final repository = new QuotesRepository();
  bool isLoading = true;
  String _quote = "";

  @override
  initState() {
    super.initState();
    repository.getRandomQuote().then((quote) {
      setState(() {
        isLoading = false;
        _quote = quote;
      });
    });
  }

  void _updateQuote() {
    setState(() {
      repository.getRandomQuote().then((quote) {
        _quote = quote;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            isLoading
                ? new CircularProgressIndicator()
                : new Padding(
                    padding: new EdgeInsets.all(16.0),
                    child: new GestureDetector(
                      onLongPress: () {
                        Share.share(_quote);
                      },
                      child: new Text(
                        '$_quote',
                        style: new TextStyle(
                          color: Colors.black87,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _updateQuote,
        tooltip: 'Другая цитата',
        child: new Icon(Icons.refresh),
      ),
    );
  }
}

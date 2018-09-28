import 'package:flutter/material.dart';
import 'quotes.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Карманный справочник Мессии',
      theme: new ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: new MessiahsHandbookQuote(title: 'Ричард Бах'),
    );
  }
}

class MessiahsHandbookQuote extends StatefulWidget {
  MessiahsHandbookQuote({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MessiahsHandbookQuoteState createState() =>
      new _MessiahsHandbookQuoteState();
}

class _MessiahsHandbookQuoteState extends State<MessiahsHandbookQuote> {
  String _quote = QuotesRepository().getRandomQuote();

  void _updateQuote() {
    setState(() {
      _quote = QuotesRepository().getRandomQuote();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // appBar: new AppBar(
      //   title: new Text(widget.title),
      // ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.all(16.0),
              child: new Text(
                '$_quote',
                style: new TextStyle(
                  color: Colors.black87,
                  fontSize: 20.0,
                ),
              ),
            ),
            // new Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.display1,
            // ),
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

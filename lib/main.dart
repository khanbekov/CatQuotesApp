import 'dart:async';
import 'dart:convert';

import 'package:cat_quotes/model/symbol.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String exchange = 'US';
String token = 'ca6a5ciad3ib7i7s2ui0';

Future<List<StockSymbol>> fetchStockSymbols(http.Client client) async {
  final response = await client.get(Uri.parse(
      'https://finnhub.io/api/v1/stock/symbol?exchange=$exchange&token=$token'));

  return compute(parseStockSymbols, response.body);
}

List<StockSymbol> parseStockSymbols(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<StockSymbol>((json) => StockSymbol.fromJson(json)).toList();
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Cat Quotes';

    return const MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<StockSymbol>>(
        future: fetchStockSymbols(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return StockSymbolsList(symbols: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class StockSymbolsList extends StatelessWidget {
  const StockSymbolsList({super.key, required this.symbols});

  final List<StockSymbol> symbols;
  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: symbols.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            symbols[index].displaySymbol,
            style: _biggerFont,
          ),
        );
      },
    );
  }
}

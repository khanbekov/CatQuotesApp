import 'package:cat_quotes/api.dart';
import 'package:cat_quotes/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Exchange, which quotes will receive
String exchange = 'US';
// Token from finhub.io
String token = 'ca6a5ciad3ib7i7s2ui0';

void main() => runApp(const CatQuotesApp());

class CatQuotesApp extends StatelessWidget {
  const CatQuotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Cat Quotes';

    return const MaterialApp(
      title: appTitle,
      home: CatQuotesHomePage(title: appTitle),
    );
  }
}

class CatQuotesHomePage extends StatelessWidget {
  const CatQuotesHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<StockSymbol>>(
        future: fetchStockSymbols(
            httpClient: http.Client(), exchange: exchange, token: token),
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
          trailing: ConstrainedBox(
            constraints: const BoxConstraints.tightFor(width: 200, height: 100),
            child: FutureBuilder(
              future: fetchQuote(
                  httpClient: http.Client(),
                  symbol: symbols[index].displaySymbol,
                  token: token),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('An error has occurred!',
                        style: TextStyle(color: Colors.red)),
                  );
                } else if (snapshot.hasData) {
                  return Text(
                    '\$${snapshot.data}',
                    textAlign: TextAlign.right,
                  );
                } else {
                  return const Text('');
                }
              },
            ),
          ),
        );
      },
    );
  }
}

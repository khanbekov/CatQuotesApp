import 'package:cat_quotes/model/symbol.dart';

const kRecordsToGenerate = 10;

class MockAPI {
  final List<StockSymbol> _store = List<StockSymbol>.generate(
      kRecordsToGenerate,
      (i) => StockSymbol(
        currency: 'symbol$i',
        description: 'symbol$i desc',
        displaySymbol: 'symbol$i',
        symbol: 'symbol$i',
        type: 'testSymbol',
        price: null,
      ));

  static final MockAPI _instance = MockAPI._internal();

  factory MockAPI() => _instance;

  MockAPI._internal() : super();

  Future<List<StockSymbol>> getSymbols() async {
    await Future.delayed(const Duration(milliseconds: 300)); // 1
    return _store;
  }
}

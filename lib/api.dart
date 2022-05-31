import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:cat_quotes/models.dart';

// Fetch all stock symbols from exchange
Future<List<StockSymbol>> fetchStockSymbols(
    {required http.Client httpClient,
    required String exchange,
    required String token}) async {
  final response = await httpClient.get(Uri.parse(
      'https://finnhub.io/api/v1/stock/symbol?exchange=$exchange&token=$token'));

  return compute(parseStockSymbols, response.body);
}

List<StockSymbol> parseStockSymbols(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<StockSymbol>((json) => StockSymbol.fromJson(json)).toList();
}

Future<Object> fetchQuote(
    {required http.Client httpClient,
    required String symbol,
    required String token}) async {
  final response = await httpClient.get(
      Uri.parse('https://finnhub.io/api/v1/quote?symbol=$symbol&token=$token'));

  return compute(parseQuote, response.body);
}

Object parseQuote(String responseBody) {
  if (kDebugMode) {
    print(responseBody);
  }
  Map<String, dynamic> parsed = jsonDecode(responseBody);
  return parsed['c'];
}

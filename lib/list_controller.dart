import 'package:cat_quotes/list_state.dart';
import 'package:cat_quotes/model/symbol.dart';
import 'package:cat_quotes/api.dart';
import 'package:flutter/foundation.dart';

class ListController extends ValueNotifier<ListState> {
  ListController() : super(ListState()) { // 1
    loadSymbols(); // 2
  }

  // 3
  Future<List<StockSymbol>> fetchSymbols() async {
    final loadedRecords = await MockAPI().getSymbols();
    return loadedRecords;
  }

  // 4
  Future<void> loadSymbols() async {
    if (value.isLoading) return; // 5

    value = value.copyWith(isLoading: true, error: ""); // 6

    try {
      final fetchResult = await fetchSymbols();

      value = value.copyWith(isLoading: false, records: fetchResult); // 7
    } catch (e) {
      value = value.copyWith(isLoading: false, error: e.toString()); // 8
      rethrow;
    }
  }

  // 9
  repeatQuery() {
    return loadSymbols();
  }
}
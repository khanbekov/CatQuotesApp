import 'package:cat_quotes/model/symbol.dart';

class ListState {
  final bool isLoading;
  final String error;
  final List<StockSymbol>? recordsStore;

  bool get isInitialized => recordsStore != null;
  bool get hasError => error.isNotEmpty;
  List<StockSymbol> get records => recordsStore ?? List<StockSymbol>.empty();

  ListState({
    List<StockSymbol>? records,
    this.isLoading = false,
    this.error = '',
  }) : recordsStore = records;

  ListState copyWith({
    List<StockSymbol>? records,
    bool? isLoading,
    String? error,
  }) {
    return ListState(
      records: records ?? recordsStore,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
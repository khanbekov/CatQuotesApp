class StockSymbol {
  final String currency;
  final String description;
  final String displaySymbol;
  final String symbol;
  final String type;

  const StockSymbol({
    required this.currency,
    required this.description,
    required this.displaySymbol,
    required this.symbol,
    required this.type,
  });

  factory StockSymbol.fromJson(Map<String, dynamic> json) {
    return StockSymbol(
      currency: json['currency'] as String,
      description: json['description'] as String,
      displaySymbol: json['displaySymbol'] as String,
      symbol: json['symbol'] as String,
      type: json['type'] as String,
    );
  }
}

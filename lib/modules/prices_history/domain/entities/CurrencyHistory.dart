class CurrencyHistory {
  final double? sellPrice;
  final double? buyPrice;
  final DateTime? recordedAt;
  final bool? isStartOfDay;

  CurrencyHistory({
    required this.sellPrice,
    required this.buyPrice,
    required this.recordedAt,
    required this.isStartOfDay,
  });
}

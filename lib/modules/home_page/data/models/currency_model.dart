class CurrencyModel {
  final int id;
  final String code;
  final double sellPrice;
  final double buyPrice;
  final int lastUpdated;

  CurrencyModel({
    required this.id,
    required this.code,
    required this.sellPrice,
    required this.buyPrice,
    required this.lastUpdated,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      id: json['id'],
      code: json['code'],
      sellPrice: json['sell_price'],
      buyPrice: json['buy_price'],
      lastUpdated: json['last_updated'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'sell_price': sellPrice,
      'buy_price': buyPrice,
      'last_updated': lastUpdated,
    };
  }
}

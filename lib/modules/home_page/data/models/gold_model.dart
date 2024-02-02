class GoldModel {
  final String? code;
  final String? name;
  final String? buyPrice;
  final String? sellPrice;
  final int? lastUpdate;

  GoldModel({
    this.code,
    this.name,
    this.buyPrice,
    this.sellPrice,
    this.lastUpdate,
  });

  factory GoldModel.fromJson(Map<String, dynamic> json) => GoldModel(
        code: json['code'],
        name: json['name'],
        buyPrice: json['buy_price'],
        sellPrice: json['sell_price'],
        lastUpdate: json['last_update'],
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
        'buy_price': buyPrice,
        'sell_price': sellPrice,
        'last_update': lastUpdate,
      };
}

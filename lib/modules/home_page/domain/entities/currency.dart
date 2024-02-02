import '../../data/models/currency_model.dart';

class Currency {
  final int? id;
  final String? code;
  final double? sellPrice;
  final double? buyPrice;
  final int? lastUpdated;

  Currency({
    this.id,
    this.code,
    this.sellPrice,
    this.buyPrice,
    this.lastUpdated,
  });
  factory Currency.fromModel(CurrencyModel model) {
    return Currency(
      id: model.id,
      code: model.code,
      sellPrice: model.sellPrice,
      buyPrice: model.buyPrice,
      lastUpdated: model.lastUpdated,
    );
  }
}

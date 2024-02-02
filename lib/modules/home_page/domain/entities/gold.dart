import '../../data/models/gold_model.dart';

class Gold {
  final String? code;
  final String? name;
  final String? buyPrice;
  final String? sellPrice;
  final int? lastUpdate;

  Gold({
    this.code,
    this.name,
    this.buyPrice,
    this.sellPrice,
    this.lastUpdate,
  });

  factory Gold.fromModel(GoldModel model) => Gold(
        code: model.code,
        name: model.name,
        buyPrice: model.buyPrice,
        sellPrice: model.sellPrice,
        lastUpdate: model.lastUpdate,
      );
}

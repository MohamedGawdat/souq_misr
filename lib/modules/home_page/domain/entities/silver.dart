import '../../data/models/silver_model.dart';

class Silver {
  final String? code;
  final String? name;
  final String? price;
  final int? lastUpdate;

  Silver({
    this.code,
    this.name,
    this.price,
    this.lastUpdate,
  });

  factory Silver.fromModel(SilverModel model) => Silver(
        code: model.code,
        name: model.name,
        price: model.price,
        lastUpdate: model.lastUpdate,
      );
}

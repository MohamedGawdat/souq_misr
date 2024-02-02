class SilverModel {
  final String? code;
  final String? name;
  final String? price;
  final int? lastUpdate;

  SilverModel({
    this.code,
    this.name,
    this.price,
    this.lastUpdate,
  });

  factory SilverModel.fromJson(Map<String, dynamic> json) => SilverModel(
        code: json['code'],
        name: json['name'],
        price: json['price'],
        lastUpdate: json['last_update'],
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
        'price': price,
        'last_update': lastUpdate,
      };
}

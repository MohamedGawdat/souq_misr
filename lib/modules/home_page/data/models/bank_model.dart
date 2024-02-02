import 'currency_model.dart';

class BankModel {
  final int? id;
  final String? name;
  final String? imageUrl;
  final String? code;
  final List<CurrencyModel>? currencies; // Added list of currencies

  BankModel({
    this.id,
    this.name,
    this.imageUrl,
    this.code,
    this.currencies, // Don't forget to initialize this in the constructor
  });

  factory BankModel.fromJson(Map<String, dynamic> json) {
    return BankModel(
      id: json['id'],
      name: json['english_name'],
      imageUrl: json['image'],
      code: json['code'],
      currencies: (json['currencies'] as List).map((e) => CurrencyModel.fromJson(e)).toList(), // Parse the currencies
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': imageUrl,
      'code': code,
      'currencies': currencies?.map((e) => e.toJson()).toList(), // Convert currencies to JSON
    };
  }
}

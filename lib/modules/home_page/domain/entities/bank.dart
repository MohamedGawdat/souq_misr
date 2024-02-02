import '../../data/models/bank_model.dart';
import 'currency.dart';

class Bank {
  final int? id;
  final String? name;
  final String? imageUrl;
  final String? code;
  final List<Currency>? currencies; // Added list of currencies

  Bank({
    this.id,
    this.name,
    this.imageUrl,
    this.code,
    this.currencies, // Initialize this in the constructor
  });

  factory Bank.fromModel(BankModel model) {
    return Bank(
      id: model.id,
      name: model.name,
      imageUrl: model.imageUrl,
      code: model.code,
      currencies: model.currencies?.map((m) => Currency.fromModel(m)).toList(), // Convert from CurrencyModel to Currency
    );
  }
}

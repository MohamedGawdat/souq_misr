import 'package:souq_misr_elmaly/modules/home_page/data/models/silver_model.dart';

import 'bank_model.dart';
import 'gold_model.dart';

class PricesApiResponseData {
  final List<BankModel> banks;
  final List<GoldModel> gold; // Make sure this line is correct
  final List<SilverModel> silver;

  PricesApiResponseData({
    required this.banks,
    required this.gold, // Make sure this line is correct
    required this.silver,
  });

  factory PricesApiResponseData.fromJson(Map<String, dynamic> json) {
    return PricesApiResponseData(
      banks: List<BankModel>.from(json['banks'].map((x) => BankModel.fromJson(x))),
      gold: List<GoldModel>.from(json['gold_prices'].map((x) => GoldModel.fromJson(x))), // And this line
      silver: List<SilverModel>.from(json['silver_prices'].map((x) => SilverModel.fromJson(x))),
    );
  }
}

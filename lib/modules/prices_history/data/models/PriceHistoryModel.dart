import '../../domain/entities/CurrencyHistory.dart';
import '../../domain/entities/PriceHistory.dart';
import 'CurrencyHistoryModel.dart';

class PriceHistoryModel {
  final List<CurrencyHistoryModel> changeHistory;

  PriceHistoryModel({required this.changeHistory});

  factory PriceHistoryModel.fromJson(Map<String, dynamic> json) {
    return PriceHistoryModel(
      changeHistory: (json['change_history'] as List).map((e) => CurrencyHistoryModel.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  PriceHistory toEntity() {
    return PriceHistory(
      changeHistory: changeHistory.map((e) => e.toEntity()).toList(),
    );
  }
}

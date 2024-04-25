import '../../domain/entities/CurrencyHistory.dart';

class CurrencyHistoryModel {
  final double sellPrice;
  final double buyPrice;
  final String recordedAt;
  final bool isStartOfDay;

  CurrencyHistoryModel({
    required this.sellPrice,
    required this.buyPrice,
    required this.recordedAt,
    required this.isStartOfDay,
  });

  factory CurrencyHistoryModel.fromJson(Map<String, dynamic> json) {
    return CurrencyHistoryModel(
      sellPrice: double.parse(json['sell_price']),
      buyPrice: double.parse(json['buy_price']),
      recordedAt: json['recorded_at'],
      isStartOfDay: json['is_start_of_day'],
    );
  }

  CurrencyHistory toEntity() {
    return CurrencyHistory(
      sellPrice: sellPrice,
      buyPrice: buyPrice,
      recordedAt: recordedAt,
      isStartOfDay: isStartOfDay,
    );
  }
}

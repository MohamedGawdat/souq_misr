import 'CurrencyHistory.dart';

class PriceHistory {
  final List<CurrencyHistory> changeHistory;

  PriceHistory({required this.changeHistory});
}

class DayWithRecords {
  final CurrencyHistory parentRecord;
  final List<CurrencyHistory> childRecords;

  DayWithRecords({required this.parentRecord, required this.childRecords});
}

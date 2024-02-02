import '../entities/CurrencyHistory.dart';
import '../entities/PriceHistory.dart';

abstract class ICurrencyHistoryRepository {
  Future<PriceHistory> getHistory(String bankName, String currName);
}

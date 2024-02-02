import 'package:souq_misr_elmaly/modules/prices_history/domain/entities/CurrencyHistory.dart';
import 'package:souq_misr_elmaly/modules/prices_history/domain/entities/PriceHistory.dart';
import 'package:souq_misr_elmaly/modules/prices_history/domain/repositories/ICurrencyHistoryRepository.dart';

class GetCurrencyHistoryUseCase {
  final ICurrencyHistoryRepository repository;

  // Constructor expects a positional argument
  GetCurrencyHistoryUseCase(this.repository);

  Future<PriceHistory> call(String bankName, String currName) async {
    return await repository.getHistory(bankName, currName);
  }
}

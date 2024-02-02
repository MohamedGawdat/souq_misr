import '../../domain/use_cases/GetCurrencyHistoryUseCase.dart';

class CurrencyHistoryViewModel {
  final GetCurrencyHistoryUseCase getCurrencyHistoryUseCase;

  CurrencyHistoryViewModel(this.getCurrencyHistoryUseCase);

  Future<void> loadCurrencyHistory(String bankName, String currName) async {
    try {
      final priceHistory = await getCurrencyHistoryUseCase(bankName, currName);
      // Use the priceHistory for your UI
    } catch (error) {
      // Handle the error
    }
  }
}

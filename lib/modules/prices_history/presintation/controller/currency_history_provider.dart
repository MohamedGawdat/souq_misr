import 'package:flutter/material.dart';
import '../../domain/entities/PriceHistory.dart';
import '../../domain/use_cases/GetCurrencyHistoryUseCase.dart';

class CurrencyHistoryProvider with ChangeNotifier {
  final GetCurrencyHistoryUseCase getCurrencyHistoryUseCase;
  CurrencyHistoryProvider(this.getCurrencyHistoryUseCase);

  PriceHistory? _priceHistory;
  PriceHistory? get priceHistory => _priceHistory;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchPriceHistory(String bankName, String currName) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();
    try {
      _priceHistory = await getCurrencyHistoryUseCase(bankName, currName);
    } catch (error) {
      _errorMessage = error.toString();
      // Log the error or send to an error tracking service
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

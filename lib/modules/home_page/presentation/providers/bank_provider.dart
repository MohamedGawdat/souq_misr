import 'package:flutter/material.dart';
import 'package:souq_misr_elmaly/modules/home_page/domain/usecases/get_banks_usecase.dart';
import '../../data/models/api_response_data.dart';
import '../../data/models/bank_model.dart';
import 'package:collection/collection.dart';

enum CurrentGoldSort { sell, buy }

enum CurrentSilverSort { sell, buy }

enum CurrentBanksSort { sell, buy }

class DataProvider with ChangeNotifier {
  final GetHomeDataUseCase getDataUseCase;
  DataProvider({required this.getDataUseCase});

  PricesApiResponseData? _data;
  String selectedCurrency = 'USD';
  List<BankModel> filteredBanks = [];
  bool isSellAscendingBanks = true;
  bool isBuyAscendingBanks = true;
  bool isSellAscendingGold = true;
  bool isBuyAscendingGold = true;
  bool isSellAscendingSilver = true;
  bool isBuyAscendingSilver = true;
  CurrentGoldSort? currentGoldSort;
  CurrentSilverSort? currentSilverSort;
  CurrentBanksSort? currentBanksSort;
  PricesApiResponseData? get data => _data;
  // String get selectedCurrency => _selectedCurrency;

  Future<void> fetchBanks() async {
    try {
      _data = await getDataUseCase.call();
      print('data is $data');
      filteredBanks = _data!.banks;
    } catch (e) {
      print('error is $e');
      // Handle errors as needed
    } finally {
      notifyListeners();
    }
  }

  void changeSelectedCurrency(String newCurr) {
    if (newCurr != selectedCurrency) {
      selectedCurrency = newCurr;
      // Optional: Add logic here if you need to fetch/update data when the currency changes
      notifyListeners();
    }
  }

  void sortGoldList(String criteria) {
    if (_data != null && _data!.gold.isNotEmpty) {
      sortList(
          _data!.gold,
          criteria == "sell" ? isSellAscendingGold : isBuyAscendingGold,
          (item) =>
              double.tryParse(criteria == "sell"
                  ? item.sellPrice ?? '0'
                  : item.buyPrice ?? '0') ??
              0);
      notifyListeners();
    }
  }

  void toggleSellSortOrderGold() {
    currentGoldSort = CurrentGoldSort.sell;
    isSellAscendingGold = !isSellAscendingGold;
    sortGoldList("sell");
  }

  void toggleBuySortOrderGold() {
    currentGoldSort = CurrentGoldSort.buy;
    isBuyAscendingGold = !isBuyAscendingGold;
    sortGoldList("buy");
  }

  void sortBanksList(String criteria) {
    if (_data != null && _data!.banks.isNotEmpty) {
      sortList<BankModel>(
        _data!.banks,
        criteria == "sell" ? isSellAscendingBanks : isBuyAscendingBanks,
        (BankModel bank) {
          double price = 0.0;
          if (criteria == "sell") {
            price = bank.currencies
                    ?.firstWhereOrNull(
                        (element) => element.code == selectedCurrency)
                    ?.sellPrice ??
                0.0;
          } else if (criteria == "buy") {
            price = bank.currencies
                    ?.firstWhereOrNull(
                        (element) => element.code == selectedCurrency)
                    ?.buyPrice ??
                0.0;
          }
          return price;
        },
      );
      notifyListeners();
    }
  }

  void toggleSellSortOrderBanks() {
    currentBanksSort = CurrentBanksSort.sell;
    isSellAscendingBanks = !isSellAscendingBanks;
    sortBanksList("sell");
  }

  void toggleBuySortOrderBanks() {
    currentBanksSort = CurrentBanksSort.buy;
    isBuyAscendingBanks = !isBuyAscendingBanks;
    sortBanksList("buy");
  }

  void sortSilverList(String criteria) {
    if (_data != null && _data!.silver.isNotEmpty) {
      _data!.silver.sort((a, b) {
        var sellA = double.tryParse(a.price ?? '0') ??
            0; // Default to 0 if null or not a number
        var sellB = double.tryParse(b.price ?? '0') ?? 0;
        return isSellAscendingSilver || isBuyAscendingSilver
            ? sellA.compareTo(sellB)
            : sellB.compareTo(sellA);
      });
      notifyListeners();
    }
  }

  void toggleSellSortOrderSilver() {
    currentSilverSort = CurrentSilverSort.sell;
    isSellAscendingSilver = !isSellAscendingSilver;
    sortSilverList("sell");
  }

  void toggleBuySortOrderSilver() {
    currentSilverSort = CurrentSilverSort.buy;
    isBuyAscendingSilver = !isBuyAscendingSilver;
    sortSilverList("buy");
  }

  void filterBanks(String query) {
    if (query.isEmpty) {
      filteredBanks = _data!.banks; // Assuming 'banks' is your original list
    } else {
      filteredBanks = _data!.banks
          .where(
              (bank) => bank.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void sortList<T>(List<T> list, bool ascending, Comparable Function(T) key) {
    list.sort((a, b) => ascending
        ? Comparable.compare(key(a), key(b))
        : Comparable.compare(key(b), key(a)));
  }
}

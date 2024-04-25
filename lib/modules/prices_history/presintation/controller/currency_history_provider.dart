import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/CurrencyHistory.dart';
import '../../domain/entities/PriceHistory.dart';
import '../../domain/use_cases/GetCurrencyHistoryUseCase.dart';

class CurrencyHistoryProvider with ChangeNotifier {
  final GetCurrencyHistoryUseCase getCurrencyHistoryUseCase;
  CurrencyHistoryProvider(this.getCurrencyHistoryUseCase);

  PriceHistory? _priceHistory;
  List<DayWithRecords> daysWithRecords = [];

  PriceHistory? get priceHistory => _priceHistory;
  List<FlSpot> sellChartData = [];
  List<FlSpot> buyChartData = [];
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  double minX = 0;
  double maxX = 0;
  double minY = 0;
  double maxY = 0;
  resetData() {
    _priceHistory = null;
    notifyListeners();
  }

  Future<void> fetchPriceHistory(String bankId, String currName) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();
    try {
      _priceHistory = await getCurrencyHistoryUseCase(bankId, currName);
      _updateChartData();
      _drawTheChartStartAndEnd();
      _processPriceHistory();
    } catch (error) {
      _errorMessage = error.toString();
      // Log the error or send to an error tracking service
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _updateChartData() {
    final priceHistory = _priceHistory;
    if (priceHistory != null) {
      sellChartData = priceHistory.changeHistory.map((history) {
        final date = DateTime.parse(history.recordedAt!);
        return FlSpot(
            date.millisecondsSinceEpoch.toDouble(), history.sellPrice!);
      }).toList();
      buyChartData = priceHistory.changeHistory.map((history) {
        final date = DateTime.parse(history.recordedAt!);
        return FlSpot(
            date.millisecondsSinceEpoch.toDouble(), history.buyPrice!);
      }).toList();
    }
  }

  _drawTheChartStartAndEnd() {
    minX = (sellChartData + buyChartData).map((spot) => spot.x).reduce(min);
    maxX = (sellChartData + buyChartData).map((spot) => spot.x).reduce(max);
    minY =
        ((sellChartData + buyChartData).map((spot) => spot.y).reduce(min) * 0.9)
            .toInt()
            .toDouble();
    maxY =
        ((sellChartData + buyChartData).map((spot) => spot.y).reduce(max) * 1.1)
            .toInt()
            .toDouble();
  }

  // void _processPriceHistory() {
  //   if (_priceHistory == null) return;
  //
  //   Map<String, List<CurrencyHistory>> groupedByDate = {};
  //
  //   // Group records by their date
  //   for (var history in _priceHistory!.changeHistory) {
  //     final date =
  //         DateFormat('yyyy-MM-dd').format(DateTime.parse(history.recordedAt!));
  //     groupedByDate.putIfAbsent(date, () => []).add(history);
  //   }
  //
  //   daysWithRecords.clear();
  //
  //   groupedByDate.forEach((date, histories) {
  //     // Sort histories of each day by recordedAt to make the last record the parent
  //     histories.sort((a, b) => a.recordedAt!.compareTo(b.recordedAt!));
  //     final parentRecord = histories.last;
  //     final childRecords = List<CurrencyHistory>.from(histories)..removeLast();
  //
  //     daysWithRecords.add(DayWithRecords(
  //         parentRecord: parentRecord, childRecords: childRecords));
  //   });
  //
  //   // Since the data has changed, notify listeners.
  //   notifyListeners();
  // }
  void _processPriceHistory() {
    if (_priceHistory == null) return;

    Map<String, List<CurrencyHistory>> groupedByDate = {};

    // Group records by their date
    for (var history in _priceHistory!.changeHistory) {
      final date =
          DateFormat('yyyy-MM-dd').format(DateTime.parse(history.recordedAt!));
      groupedByDate.putIfAbsent(date, () => []).add(history);
    }

    daysWithRecords.clear();

    groupedByDate.forEach((date, histories) {
      // Sort histories of each day by recordedAt to make the last record the parent
      histories.sort((a, b) => a.recordedAt!.compareTo(b.recordedAt!));
      final parentRecord = histories.last;
      // No need to remove the last record for childRecords as parent is also included in the day's records
      final childRecords = List<CurrencyHistory>.from(histories);

      daysWithRecords.add(DayWithRecords(
          parentRecord: parentRecord, childRecords: childRecords));
    });

    // Since the data has changed, notify listeners.
    notifyListeners();
  }
}

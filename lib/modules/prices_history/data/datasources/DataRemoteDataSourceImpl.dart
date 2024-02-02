import '../../../../data/network/ApiManager.dart';
import '../../../../data/network/ApiResponse.dart';
import '../../domain/entities/CurrencyHistory.dart';
import '../../domain/repositories/ICurrencyHistoryRepository.dart';
import '../models/CurrencyHistoryModel.dart';

import '../../../../data/network/ApiManager.dart';
import '../../../../data/network/ApiResponse.dart';
import '../models/PriceHistoryModel.dart';
import '../models/CurrencyHistoryModel.dart';

abstract class IRemoteDataSource {
  Future<PriceHistoryModel> getHistory(String bankName, String currName);
}

class PriceHistoryDataRemoteDataSourceImpl implements IRemoteDataSource {
  @override
  Future<PriceHistoryModel> getHistory(String bankName, String currName) async {
    final ApiResponse response = await ApiManager.sendRequest(
      link: '/api/v1/price-history/$bankName/$currName',
      method: Method.GET,
    );

    if (response.isSuccess && response.data != null) {
      return PriceHistoryModel.fromJson(response.data!);
    } else {
      throw Exception('Failed to load data: ${response.message}');
    }
  }
}

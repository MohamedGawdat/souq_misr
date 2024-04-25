import '../../../../data/network/ApiManager.dart';
import '../../../../data/network/ApiResponse.dart';
import '../../domain/repository/IHomeRepository.dart';
import '../models/api_response_data.dart';
import '../models/prices_model.dart';

abstract class IHomeRemoteDataSource {
  Future<PricesApiResponseData> getData();
}

class HomeDataRemoteDataSourceImpl implements IHomeRemoteDataSource {
  @override
  Future<PricesApiResponseData> getData() async {
    late ApiResponse response;
    try {
      response = await ApiManager.sendRequest(
        link: '/api/v1/banks/',
        method: Method.GET,
      );

      if (response.isSuccess && response.data != null) {
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('catch $e');
    }
    return PricesApiResponseData.fromJson(response.data!);
  }
}

class GetPricesData {
  Future<PricesModel> getData(String bankName, String currenyName) async {
    final ApiResponse response = await ApiManager.sendRequest(
      link: '/api/v1/$bankName/$currenyName', // Update with actual endpoint
      method: Method.GET,
    );

    if (response.isSuccess && response.data != null) {
      return PricesModel.fromJson(response.data!);
    } else {
      throw Exception('Failed to load data');
    }
  }
}

import '../../data/datasources/bank_remote_data_source.dart';
import '../../data/models/api_response_data.dart';

abstract class IHomeRepository {
  Future<PricesApiResponseData> getData();
}

class HomeRepositoryImpl implements IHomeRepository {
  final IHomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<PricesApiResponseData> getData() async {
    // Your implementation to fetch data goes here
    return await remoteDataSource.getData();
  }
}

import '../../data/datasources/bank_remote_data_source.dart';
import '../../data/models/api_response_data.dart';
import '../repository/IHomeRepository.dart';

class HomeRepository implements IHomeRepository {
  final IHomeRemoteDataSource dataSource;

  HomeRepository(this.dataSource);

  @override
  Future<PricesApiResponseData> getData() async {
    return await dataSource.getData();
  }
}

class GetHomeDataUseCase {
  final IHomeRepository repository;

  GetHomeDataUseCase(this.repository);

  Future<PricesApiResponseData> call() async {
    try {
      return await repository.getData();
    } catch (e) {
      print('Error fetching home data: $e');
      rethrow;
    }
  }
}

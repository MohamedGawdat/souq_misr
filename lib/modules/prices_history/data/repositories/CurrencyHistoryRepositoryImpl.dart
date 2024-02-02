import 'package:souq_misr_elmaly/modules/prices_history/domain/entities/CurrencyHistory.dart';
import 'package:souq_misr_elmaly/modules/prices_history/domain/entities/PriceHistory.dart';
import 'package:souq_misr_elmaly/modules/prices_history/domain/repositories/ICurrencyHistoryRepository.dart';
import 'package:souq_misr_elmaly/modules/prices_history/data/datasources/DataRemoteDataSourceImpl.dart';

class CurrencyHistoryRepositoryImpl implements ICurrencyHistoryRepository {
  final IRemoteDataSource remoteDataSource;

  CurrencyHistoryRepositoryImpl(this.remoteDataSource);

  @override
  Future<PriceHistory> getHistory(String bankName, String currName) async {
    final data = await remoteDataSource.getHistory(bankName, currName);
    return data.toEntity(); // Convert PriceHistoryModel to PriceHistory
  }
}

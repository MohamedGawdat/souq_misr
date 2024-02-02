import 'package:souq_misr_elmaly/modules/home_page/domain/repository/bank_repository.dart';
import 'package:souq_misr_elmaly/modules/home_page/data/datasources/bank_remote_data_source.dart';
import 'package:souq_misr_elmaly/modules/home_page/domain/entities/bank.dart';

import '../../domain/entities/gold.dart';
import '../../domain/entities/silver.dart';
import '../../domain/repository/gold_repository.dart';
import '../../domain/repository/silver_repository.dart';
import '../models/api_response_data.dart';

class RepositoryImpl implements BankRepository, GoldRepository, SilverRepository {
  final HomeDataRemoteDataSourceImpl remoteDataSource;

  RepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Bank>> getBanks() async {
    final data = await remoteDataSource.getData();
    return data.banks.map((model) => Bank.fromModel(model)).toList();
  }

  @override
  Future<List<Gold>> getGoldPrices() async {
    final data = await remoteDataSource.getData();
    return data.gold.map((model) => Gold.fromModel(model)).toList();
  }

  @override
  Future<List<Silver>> getSilverPrices() async {
    final data = await remoteDataSource.getData();
    return data.silver.map((model) => Silver.fromModel(model)).toList();
  }
}

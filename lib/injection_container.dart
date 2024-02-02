import 'package:get_it/get_it.dart';
import 'package:souq_misr_elmaly/modules/prices_history/domain/use_cases/GetCurrencyHistoryUseCase.dart';
import 'package:souq_misr_elmaly/modules/prices_history/data/repositories/CurrencyHistoryRepositoryImpl.dart';
import 'package:souq_misr_elmaly/modules/prices_history/data/datasources/DataRemoteDataSourceImpl.dart';
import 'package:souq_misr_elmaly/modules/prices_history/domain/repositories/ICurrencyHistoryRepository.dart';

import 'modules/home_page/data/datasources/bank_remote_data_source.dart';
import 'modules/home_page/domain/repository/IHomeRepository.dart';
import 'modules/home_page/domain/usecases/get_banks_usecase.dart';
import 'modules/home_page/presentation/providers/bank_provider.dart';
import 'modules/prices_history/presintation/controller/currency_history_provider.dart';

final sl = GetIt.instance;

void init() {
  // Providers
  sl.registerFactory(
    () => CurrencyHistoryProvider(sl<GetCurrencyHistoryUseCase>()),
  );
  sl.registerFactory(
    () => DataProvider(getDataUseCase: sl<GetHomeDataUseCase>()),
  );

  // Use cases
  sl.registerLazySingleton(
    () => GetCurrencyHistoryUseCase(sl<ICurrencyHistoryRepository>()),
  );
  sl.registerLazySingleton(
    () => GetHomeDataUseCase(sl<IHomeRepository>()),
  );

  // Repositories
  sl.registerLazySingleton<ICurrencyHistoryRepository>(
    () => CurrencyHistoryRepositoryImpl(sl<IRemoteDataSource>()),
  );
  sl.registerLazySingleton<IHomeRepository>(
    () => HomeRepositoryImpl(sl<IHomeRemoteDataSource>()),
  );

  // Data sources
  sl.registerLazySingleton<IRemoteDataSource>(
    () => PriceHistoryDataRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<IHomeRemoteDataSource>(
    () => HomeDataRemoteDataSourceImpl(), // If DataRemoteDataSourceImpl implements IHomeRemoteDataSource
  );

  // Core & External
  // ... e.g., ApiManager if it's not static and needs to be injected
}

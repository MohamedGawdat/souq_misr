import 'package:get_it/get_it.dart';

import '../../data/datasources/bank_remote_data_source.dart';

import 'get_banks_usecase.dart';

final getIt = GetIt.instance;

// void setupServiceLocator() {
//   getIt.registerLazySingleton<HomeRepository>(
//     () => DataRemoteDataSourceImpl(), // Should be your repository implementation
//   );
//
//   getIt.registerFactory(() => GetHomeDataUseCase(getIt.get<HomeRepository>()));
// }

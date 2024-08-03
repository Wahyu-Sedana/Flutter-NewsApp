import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/cores/settings/dio_client.dart';
import 'package:news_app/cores/settings/network_info.dart';
import 'package:news_app/features/dashboard/presentation/provider/dashboard_provider.dart';
import 'package:news_app/features/history/presentation/providers/history_provider.dart';
import 'package:news_app/features/home/data/datasource/home_datasource.dart';
import 'package:news_app/features/home/data/repository/home_repository.dart';
import 'package:news_app/features/home/domain/usecase/home_usecase.dart';
import 'package:news_app/features/home/presentation/provider/home_provider.dart';
import 'package:news_app/features/search/presentation/provider/search_provider.dart';

final locator = GetIt.instance;

Future<void> locatorInit() async {
  // external
  locator.registerLazySingleton<Dio>(() => DioClient().dio);
  locator.registerLazySingleton<Connectivity>(() => Connectivity());
  locator
      .registerLazySingleton<NetworkInfo>(() => NetworkInfoImplementation(locator<Connectivity>()));

  // datasource
  locator.registerLazySingleton<HomeDataSource>(() => HomeDataSourceImpl(dio: locator<Dio>()));

  // repository
  locator.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(
      homeDataSource: locator<HomeDataSource>(), networkInfo: locator<NetworkInfo>()));

  // usecase
  locator.registerLazySingleton<HomeUseCase>(
      () => GetNewsUseCase(homeRepository: locator<HomeRepository>()));

  // provider
  locator.registerFactory<DashboardProvider>(() => DashboardProvider());
  locator.registerFactory<HomeProvider>(() => HomeProvider(homeUseCase: locator<HomeUseCase>()));
  locator.registerFactory<SearchProvider>(() => SearchProvider());
  locator.registerFactory<HistoryProvider>(() => HistoryProvider());
}

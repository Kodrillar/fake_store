import 'package:fake_store/src/features/auth/data/network/auth.dart';
import 'package:fake_store/src/features/auth/data/repository/auth.dart';
import 'package:fake_store/src/features/home/data/home_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt getIt = GetIt.instance;

class ServiceLocators {
  ServiceLocators._();

  static void register() {
    getIt.registerSingleton<Dio>(
        Dio(BaseOptions(baseUrl: 'https://fakestoreapi.com')));

    getIt.registerSingletonAsync<SharedPreferences>(
      () async => SharedPreferences.getInstance(),
    );

    getIt.registerLazySingleton<AuthNetworkHelper>(() => AuthNetworkHelper());

    getIt.registerLazySingleton<AuthRepository>(() => AuthRepository());

    getIt.registerLazySingleton<HomeRepository>(() => HomeRepository());
  }
}

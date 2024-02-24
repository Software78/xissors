import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:xissors/core/network/api_client_impl.dart';
import 'package:xissors/features/auth/data/respository/auth_repository.dart';
import 'package:xissors/features/products/data/repository/product_repo_impl.dart';

import '../../core/navigation/navigator.dart';
import '../core/network/api_client.dart';
import '../features/auth/data/respository/auth_repo_impl.dart';
import '../features/products/data/repository/product_repo.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppInitializer {
  static late GetIt instanceLocator;

  // AppInitializer._();

  void close() {
    instanceLocator.reset();
  }

  static Future<void> init() async {
    instanceLocator = GetIt.instance;
    
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    initialize();
  }

  static void initialize() {
    initializeNavigator();
    initializeRemoteDataSources();
    initializeRepo();
  }

  static void initializeNavigator() {
    instanceLocator.registerLazySingleton<NavigationService>(
      () => GoRouterNavigatorImpl(navigatorKey),
    );
  }

  static void initializeLocalDataSources() {
    // instanceLocator.registerLazySingleton<StorageClient>(
    //   () => PrefsStorageImpl(),
    // );   
  }

 

  static void initRepos() {
    // instanceLocator
    //     .registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  }

  static void initializeRemoteDataSources() {
    instanceLocator.registerLazySingleton<ApiClient>(
      () => DioApiClient(),
    );
  }

  static void initializeRepo() {
    instanceLocator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        apiClient: instanceLocator.get<ApiClient>(),
      ),
    );
    instanceLocator.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(
        apiClient: instanceLocator.get<ApiClient>(),
      ),
    );
  }
}

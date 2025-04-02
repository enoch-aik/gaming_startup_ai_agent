import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gaming_startup_ai_agent/core/config/api_config/api_config.dart';
import 'package:gaming_startup_ai_agent/core/config/app_config/app_config.dart';
import 'package:gaming_startup_ai_agent/core/service_result/src/api_result.dart';
import 'package:gaming_startup_ai_agent/core/services/api/api_client.dart';
import 'package:gaming_startup_ai_agent/core/services/storage/storage.dart';
import 'package:gaming_startup_ai_agent/env.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//flavor selector
final currentEnvProvider = StateProvider<AppEnv>((ref) => AppEnv.development);

//appConfig
final appConfigProvider = Provider<AppConfig>((ref) {
  AppEnv currentEnv = ref.watch(currentEnvProvider);
  return AppConfig.fromJson(switch (currentEnv) {
    AppEnv.production => productionAppConfig,
    AppEnv.development => developmentAppConfig,
    AppEnv.staging => stagingAppConfig,
  });
});

//firebase provider
final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);

//storage providers
final storeProvider = Provider((ref) {
  return Storage();
});
//apiConfig
final apiConfigProvider = Provider<ApiConfig>((ref) {
  return ApiConfig(ref.read(appConfigProvider).baseUrl);
});

//apiClient
final apiClientProvider = Provider<ApiClient>((ref) {
  final config = ref.read(apiConfigProvider);
  return ApiClient(config);
});

typedef UseCaseFunc<T> = Future<ApiResult<T>> Function();

/*class UseCase<T> {
  Future<ApiResult<T>> call(UseCaseFunc<T> function) async => await function();

  Future<T> init(UseCaseFunc<T> function) async => (await function()).extract();
}*/

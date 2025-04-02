import 'package:gaming_startup_ai_agent/core/interceptor/api_interceptor.dart';
import 'package:gaming_startup_ai_agent/core/service_result/src/api_result.dart';
import 'package:gaming_startup_ai_agent/features/auth/data/data_source/auth_impl.dart';
import 'package:gaming_startup_ai_agent/features/auth/domain/repo/auth_repo.dart';
import 'package:gaming_startup_ai_agent/features/auth/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthRepositoryImplementation extends AuthRepository {
  final Ref _ref;

  AuthRepositoryImplementation(this._ref);

  late final AuthDataSourceImplementation authDataSource = _ref.read(
    authDataSourceProvider,
  );

  @override
  Future<ApiResult<bool>> anonymousSignIn() async =>
      apiInterceptor(() => authDataSource.anonymousSignIn());
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:gaming_startup_ai_agent/core/interceptor/api_interceptor.dart';
import 'package:gaming_startup_ai_agent/core/service_result/src/api_result.dart';
import 'package:gaming_startup_ai_agent/features/auth/data/data_source/auth_datasource_impl.dart';
import 'package:gaming_startup_ai_agent/features/auth/data/models/user_auth_information.dart';
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
  Future<ApiResult<UserCredential>> anonymousSignIn(String username) async =>
      apiInterceptor(() => authDataSource.anonymousSignIn(username));

  @override
  Future<ApiResult<UserAuthInformation>> getUserInformation(String username) =>
      apiInterceptor(() => authDataSource.getUserInformation(username));

  @override
  Future<ApiResult<UserAuthInformation>> getUserInformationFromUid(
    String uid,
  ) => apiInterceptor(() => authDataSource.getUserInformationFromUid(uid));
}

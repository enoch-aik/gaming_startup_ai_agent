import 'package:firebase_auth/firebase_auth.dart';
import 'package:gaming_startup_ai_agent/core/service_result/src/api_result.dart';
import 'package:gaming_startup_ai_agent/features/auth/data/models/user_auth_information.dart';

abstract class AuthRepository {
  Future<ApiResult<UserCredential>> anonymousSignIn(String username);

  Future<ApiResult<UserAuthInformation>> getUserInformation(String username);
  Future<ApiResult<UserAuthInformation>> getUserInformationFromUid(String uid);
}
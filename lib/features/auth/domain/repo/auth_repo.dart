import 'package:gaming_startup_ai_agent/core/service_result/src/api_result.dart';

abstract class AuthRepository {
  Future<ApiResult<bool>> anonymousSignIn();

}
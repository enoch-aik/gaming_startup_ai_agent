import 'package:gaming_startup_ai_agent/core/service_result/src/api_result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

extension ApiResultExtenstion on ApiResult {
  // extract the data from the result
  extract({dynamic error}) {
    return when(
      success: (data) => data,
      apiFailure: (e, _) => throw error ?? e,
    );
  }

  extractWhenData({dynamic error}) {}

  AsyncValue asyncGuard() {
    return when(
      success: (data) => AsyncData(data),
      apiFailure: (error, _) => AsyncError(error, StackTrace.empty),
    );
  }
}

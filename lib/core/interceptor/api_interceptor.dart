import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:gaming_startup_ai_agent/core/service_exceptions/src/api_exceptions.dart';
import 'package:gaming_startup_ai_agent/core/service_result/src/api_result.dart';

typedef TypeDef = Function();

Future<ApiResult<T>> apiInterceptor<T>(TypeDef func) async {
  try {
    final result = await func();

    return ApiResult.success(data: result);
  } on FirebaseException catch (exception) {
    return ApiResult.apiFailure(
      error:
      ApiExceptions.defaultError(exception.message ?? 'An error occurred'),
      statusCode: -1,
    );
  } on FireBaseAuthError catch (exception) {
    return ApiResult.apiFailure(
      error: ApiExceptions.defaultError(exception.message),
      statusCode: -1,
    );
  } on Error catch (e) {
    debugPrint(e.stackTrace.toString());
    return ApiResult.apiFailure(
      error: ApiExceptions.getDioException(e)!,
      statusCode: -1,
    );
  } catch (e) {
    debugPrint(e.toString());
    return ApiResult.apiFailure(
      error: ApiExceptions.getDioException(e)!,
      statusCode: -1,
    );
  }
}

ApiResult<T> streamInterceptor<T>(TypeDef func) {
  try {
    final result = func();

    return ApiResult.success(data: result);
  } on FirebaseException catch (exception) {
    return ApiResult.apiFailure(
      error:
      ApiExceptions.defaultError(exception.message ?? 'An error occurred'),
      statusCode: -1,
    );
  } on FireBaseAuthError catch (exception) {
    return ApiResult.apiFailure(
      error: ApiExceptions.defaultError(exception.message),
      statusCode: -1,
    );
  } on Error catch (e) {
    debugPrint(e.stackTrace.toString());
    return ApiResult.apiFailure(
      error: ApiExceptions.getDioException(e)!,
      statusCode: -1,
    );
  } catch (e) {
    debugPrint(e.toString());
    return ApiResult.apiFailure(
      error: ApiExceptions.getDioException(e)!,
      statusCode: -1,
    );
  }
}

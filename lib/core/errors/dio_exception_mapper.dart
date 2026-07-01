import 'package:dio/dio.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';

Failure mapDioExceptionToFailure(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.connectionError:
      return const NetworkFailure();
    default:
      final response = e.response;
      if (response == null) {
        return const NetworkFailure();
      }
      if (response.statusCode == 401) {
        return const AuthFailure();
      }
      return ServerFailure(
        message: _extractErrorMessage(response.data),
        statusCode: response.statusCode,
      );
  }
}

String _extractErrorMessage(dynamic data) {
  if (data is Map<String, dynamic>) {
    if (data['detail'] is String) return data['detail'] as String;
    // Format DRF classique : {"username": ["This field is required."]}
    for (final value in data.values) {
      if (value is List && value.isNotEmpty) return value.first.toString();
      if (value is String) return value;
    }
  }
  return "Une erreur est survenue.";
}

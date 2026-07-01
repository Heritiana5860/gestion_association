import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/network/auth_interceptor.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/network/dio_client.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/providers/flutter_secure_storage_provider.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = DioClient.instance;
  final storage = ref.watch(secureStorageProvider);

  dio.interceptors.clear();
  dio.interceptors.add(AuthInterceptor(dio: dio, storage: storage));

  return dio;
});

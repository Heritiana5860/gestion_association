import 'package:dio/dio.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/network/api_endpoints.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/models/president_model.dart';

abstract class PresidentDatasource {
  Future<void> addPresident(PresidentModel model);
  Future<List<PresidentModel>> presidents();
  Future<void> updatePresident({
    required int id,
    required PresidentModel model,
  });
}

class PresidentDatasourceImpl implements PresidentDatasource {
  final Dio dio;

  const PresidentDatasourceImpl({required this.dio});

  @override
  Future<void> addPresident(PresidentModel model) async {
    await dio.post(ApiEndpoints.president, data: model.toJson());
  }

  @override
  Future<List<PresidentModel>> presidents() async {
    final response = await dio.get(ApiEndpoints.president);

    final List<dynamic> data = response.data;

    return data.map((e) => PresidentModel.fromJson(e)).toList();
  }

  @override
  Future<void> updatePresident({
    required int id,
    required PresidentModel model,
  }) async {
    await dio.put("${ApiEndpoints.president}$id/", data: model.toJson());
  }
}

import 'package:dio/dio.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/network/api_endpoints.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/models/honneur_model.dart';

abstract class HonneurDatasource {
  Future<void> addHonneur(HonneurModel model);
  Future<List<HonneurModel>> honneurs();
  Future<void> updateHonneur({required int id, required HonneurModel model});
}

class HonneurDatasourceImpl implements HonneurDatasource {
  final Dio dio;

  const HonneurDatasourceImpl({required this.dio});

  @override
  Future<void> addHonneur(HonneurModel model) async {
    await dio.post(ApiEndpoints.honneur, data: model.toJson());
  }

  @override
  Future<List<HonneurModel>> honneurs() async {
    final response = await dio.get(ApiEndpoints.honneur);
    final List<dynamic> data = response.data;

    return data.map((e) => HonneurModel.fromJson(e)).toList();
  }

  @override
  Future<void> updateHonneur({
    required int id,
    required HonneurModel model,
  }) async {
    await dio.put("${ApiEndpoints.honneur}$id/", data: model.toJson());
  }
}

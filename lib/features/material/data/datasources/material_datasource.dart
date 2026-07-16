import 'package:dio/dio.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/network/api_endpoints.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/material/data/models/material_model.dart';

abstract class MaterialDatasource {
  Future<void> addMaterial(MaterialModel model);
  Future<List<MaterialModel>> materials();
  Future<void> updateMaterial({required int id, required MaterialModel model});
  Future<void> deleteMaterial(int id);
}

class MaterialDatasourceImpl implements MaterialDatasource {
  final Dio dio;

  const MaterialDatasourceImpl({required this.dio});

  @override
  Future<void> addMaterial(MaterialModel model) async {
    await dio.post(ApiEndpoints.material, data: model.toJson());
  }

  @override
  Future<List<MaterialModel>> materials() async {
    final response = await dio.get(ApiEndpoints.material);
    final List<dynamic> res = response.data;

    return res.map((e) => MaterialModel.fromJson(e)).toList();
  }

  @override
  Future<void> updateMaterial({
    required int id,
    required MaterialModel model,
  }) async {
    await dio.put("${ApiEndpoints.material}$id/", data: model.toJson());
  }

  @override
  Future<void> deleteMaterial(int id) async {
    await dio.delete("${ApiEndpoints.material}$id/");
  }
}

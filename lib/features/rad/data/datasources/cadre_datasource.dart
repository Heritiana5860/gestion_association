import 'package:dio/dio.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/network/api_endpoints.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/models/cadre_model.dart';

abstract class CadreDatasource {
  Future<List<CadreModel>> cadres();
  Future<void> addCadre(CadreModel model);
  Future<void> updateCadre({required int id, required CadreModel model});
}

class CadreDatasourceImpl implements CadreDatasource {
  final Dio dio;

  const CadreDatasourceImpl({required this.dio});

  @override
  Future<void> addCadre(CadreModel model) async {
    await dio.post(ApiEndpoints.cadre, data: model.toJson());
  }

  @override
  Future<List<CadreModel>> cadres() async {
    final response = await dio.get(ApiEndpoints.cadre);
    final List<dynamic> data = response.data;

    return data.map((e) => CadreModel.fromJson(e)).toList();
  }

  @override
  Future<void> updateCadre({required int id, required CadreModel model}) async {
    await dio.put("${ApiEndpoints.cadre}$id/", data: model.toJson());
  }
}

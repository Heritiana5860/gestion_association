import 'package:dio/dio.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/network/api_endpoints.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/models/college_model.dart';

abstract class CollegeDatasource {
  Future<void> addCollege(CollegeModel model);
  Future<List<CollegeModel>> colleges(String year);
  Future<void> updateCollege({required int id, required CollegeModel model});
}

class CollegeDatasourceImpl implements CollegeDatasource {
  final Dio dio;

  const CollegeDatasourceImpl({required this.dio});

  @override
  Future<void> addCollege(CollegeModel model) async {
    await dio.post(ApiEndpoints.college, data: model.toJson());
  }

  @override
  Future<List<CollegeModel>> colleges(String year) async {
    final response = await dio.get(
      ApiEndpoints.college,
      queryParameters: {'year': year},
    );

    final List<dynamic> data = response.data;

    return data.map((e) => CollegeModel.fromJson(e)).toList();
  }

  @override
  Future<void> updateCollege({
    required int id,
    required CollegeModel model,
  }) async {
    await dio.put("${ApiEndpoints.college}$id/", data: model.toJson());
  }
}

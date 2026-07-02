import 'package:dio/dio.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/network/api_endpoints.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/data/models/add_cotisation_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/data/models/cotisation_model.dart';

abstract class CotisationDatasource {
  Future<List<CotisationModel>> cotisations({
    String? search,
    required String year,
  });
  Future<void> addCotisation(AddCotisationModel model);
}

class CotisationDatasourceImpl implements CotisationDatasource {
  final Dio dio;

  const CotisationDatasourceImpl({required this.dio});

  @override
  Future<List<CotisationModel>> cotisations({
    String? search,
    required String year,
  }) async {
    final Map<String, dynamic> queryParams = {};
    queryParams['year'] = year;

    if (search != null && search.isNotEmpty) {
      queryParams['search'] = search.trim();
    }

    final response = await dio.get(
      ApiEndpoints.cotisation,
      queryParameters: queryParams,
    );

    final List<dynamic> data = response.data;

    return data.map((e) => CotisationModel.fromJson(e)).toList();
  }

  @override
  Future<void> addCotisation(AddCotisationModel model) async {
    await dio.post(ApiEndpoints.addCotisation, data: model.toJson());
  }
}

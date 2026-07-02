import 'package:dio/dio.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/network/api_endpoints.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/data/models/cotisation_stats_model.dart';

abstract class CotisationStatsDatasource {
  Future<CotisationStatsModel> cotisationStats(String year);
}

class CotisationStatsDatasourceImpl implements CotisationStatsDatasource {
  final Dio dio;

  const CotisationStatsDatasourceImpl({required this.dio});

  @override
  Future<CotisationStatsModel> cotisationStats(String year) async {
    final response = await dio.get(
      ApiEndpoints.cotisationSatats,
      queryParameters: {'year': year},
    );

    return CotisationStatsModel.fromJson(response.data);
  }
}

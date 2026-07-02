import 'package:dio/dio.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/network/api_endpoints.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/data/models/member_stats_model.dart';

abstract class MemberStatsDatasource {
  Future<MemberStatsModel> memberStats();
}

class MemberStatsDatasourceImpl implements MemberStatsDatasource {
  final Dio dio;

  const MemberStatsDatasourceImpl({required this.dio});

  @override
  Future<MemberStatsModel> memberStats() async {
    final response = await dio.get(ApiEndpoints.memberStats);

    final Map<String, dynamic> data = response.data;

    return MemberStatsModel.fromJson(data);
  }
}

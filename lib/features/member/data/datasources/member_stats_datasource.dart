import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/data/models/member_stats_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_stats_entity.dart';

class MemberStatsDatasource {
  final Dio dio;

  const MemberStatsDatasource({required this.dio});

  Future<MemberStatsEntity> stats() async {
    final baseUrl = dotenv.env['url'] ?? "";
    final response = await dio.get("${baseUrl}member/statistics/");

    final Map<String, dynamic> data = response.data;

    return MemberStatsModel.fromJson(data);
  }
}

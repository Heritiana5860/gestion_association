import 'package:dio/dio.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/network/api_endpoints.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/data/models/member_model.dart';

abstract class MemberDatasource {
  Future<List<MemberModel>> members({
    Map<String, dynamic>? params,
    required String year,
  });

  Future<void> addMember(MemberModel model);
  Future<void> updateMember({required int id, required MemberModel model});
  Future<void> deleteMember(int id);
  Future<MemberModel> detailMember({required int id, required String year});
}

class MemberDatasourceImpl implements MemberDatasource {
  final Dio dio;

  const MemberDatasourceImpl({required this.dio});

  @override
  Future<List<MemberModel>> members({
    Map<String, dynamic>? params,
    required String year,
  }) async {
    final Map<String, dynamic> queryQueryParams = {
      if (params != null) ...params,
      'year': year,
    };

    final response = await dio.get(
      ApiEndpoints.member,
      queryParameters: queryQueryParams,
    );

    final List<dynamic> data = response.data;

    return data.map((e) => MemberModel.fromJson(e)).toList();
  }

  @override
  Future<void> addMember(MemberModel model) async {
    await dio.post(ApiEndpoints.member, data: model.toJson());
  }

  @override
  Future<void> updateMember({
    required int id,
    required MemberModel model,
  }) async {
    await dio.put("${ApiEndpoints.member}$id/", data: model.toJson());
  }

  @override
  Future<void> deleteMember(int id) async {
    await dio.delete("${ApiEndpoints.member}$id/");
  }

  @override
  Future<MemberModel> detailMember({
    required int id,
    required String year,
  }) async {
    final response = await dio.get(
      "${ApiEndpoints.member}$id/",
      queryParameters: {'year': year},
    );

    return MemberModel.fromJson(response.data);
  }
}

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/network_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/server_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/validation_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/data/datasources/member_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/data/models/member_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/repositories/member_repository.dart';

class MemberRepositoryImpl implements MemberRepository {
  final MemberDatasource datasource;

  const MemberRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, List<MemberEntity>>> members({
    Map<String, dynamic>? params,
  }) async {
    try {
      final response = await datasource.fetchMembers(params: params);
      return Right(response);
    } on SocketException {
      return Left(NetworkError());
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        return Left(ValidationError(e.response?.data));
      }
      return Left(ServerError());
    } on Exception {
      return Left(ServerError());
    }
  }

  @override
  Future<Either<Failure, void>> addMember({required MemberModel model}) async {
    try {
      final response = await datasource.add(model: model);
      return Right(response);
    } on SocketException {
      return Left(NetworkError());
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        return Left(ValidationError(e.response?.data));
      }
      return Left(ServerError());
    } on Exception {
      return Left(ServerError());
    }
  }

  @override
  Future<void> updateMember({
    required int id,
    required MemberModel model,
  }) async {
    await datasource.update(id: id, model: model);
  }

  @override
  Future<MemberEntity> detailMember({required int id}) {
    return datasource.detail(id: id);
  }

  @override
  Future<void> deleteMember({required int id}) {
    return datasource.delete(id: id);
  }
}

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/dio_exception_mapper.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
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
    required String year,
  }) async {
    try {
      final response = await datasource.members(params: params, year: year);
      return Right(response);
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addMember(MemberEntity entity) async {
    try {
      final model = MemberModel(
        fullName: entity.fullName,
        numberPhone: entity.numberPhone,
        isInside: entity.isInside,
        cde: entity.cde,
        statut: entity.statut,
      );

      final res = await datasource.addMember(model);
      return Right(res);
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateMember({
    required int id,
    required MemberEntity entity,
  }) async {
    try {
      final model = MemberModel(
        fullName: entity.fullName,
        numberPhone: entity.numberPhone,
        isInside: entity.isInside,
        cde: entity.cde,
        statut: entity.statut,
      );

      final res = await datasource.updateMember(id: id, model: model);
      return Right(res);
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, MemberEntity>> detailMember({
    required int id,
    required String year,
  }) async {
    try {
      final res = await datasource.detailMember(id: id, year: year);
      return Right(res);
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMember(int id) async {
    try {
      final res = await datasource.deleteMember(id);
      return Right(res);
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

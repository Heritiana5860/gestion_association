import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/dio_exception_mapper.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/datasources/honneur_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/models/honneur_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/honneur_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/repositories/honneur_repository.dart';

class HonneurRepositoryImpl implements HonneurRepository {
  final HonneurDatasource datasource;

  const HonneurRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, void>> newHonneur({
    required HonneurModel model,
  }) async {
    try {
      final res = await datasource.addHonneur(model: model);
      return Right(res);
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<HonneurEntity>>> fetchHonneur() async {
    try {
      final res = await datasource.getHonneur();
      return Right(res);
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateHonneur({
    required int id,
    required HonneurModel model,
  }) async {
    try {
      final res = await datasource.updateHonneur(id: id, model: model);
      return Right(res);
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

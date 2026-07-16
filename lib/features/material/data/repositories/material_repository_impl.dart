import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/dio_exception_mapper.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/material/data/datasources/material_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/material/data/models/material_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/material/domain/entities/material_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/material/domain/repositories/material_repository.dart';

class MaterialRepositoryImpl implements MaterialRepository {
  final MaterialDatasource datasource;

  const MaterialRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, void>> addMaterial(MaterialEntity entity) async {
    try {
      final model = MaterialModel(
        nom: entity.nom,
        description: entity.description,
        nombreMateriel: entity.nombreMateriel,
      );
      final res = await datasource.addMaterial(model);

      return Right(res);
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MaterialEntity>>> materials() async {
    try {
      final res = await datasource.materials();
      return Right(res);
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateMaterial({
    required int id,
    required MaterialEntity entity,
  }) async {
    try {
      final model = MaterialModel(
        nom: entity.nom,
        description: entity.description,
        nombreMateriel: entity.nombreMateriel,
      );
      final res = await datasource.updateMaterial(id: id, model: model);
      return Right(res);
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMaterial(int id) async {
    try {
      final res = await datasource.deleteMaterial(id);
      return Right(res);
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

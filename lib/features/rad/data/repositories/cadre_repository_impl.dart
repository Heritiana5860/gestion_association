import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/dio_exception_mapper.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/datasources/cadre_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/models/cadre_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/cadre_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/repositories/cadre_repository.dart';

class CadreRepositoryImpl implements CadreRepository {
  final CadreDatasource datasource;

  const CadreRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, void>> addCadre(CadreEntity entity) async {
    try {
      final model = CadreModel(
        nom: entity.nom,
        fonction: entity.fonction,
        contact: entity.contact,
        address: entity.address,
      );

      final res = await datasource.addCadre(model);
      return Right(res);
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CadreEntity>>> cadres() async {
    try {
      final res = await datasource.cadres();
      return Right(res);
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateCadre({
    required int id,
    required CadreEntity entity,
  }) async {
    try {
      final model = CadreModel(
        nom: entity.nom,
        fonction: entity.fonction,
        contact: entity.contact,
        address: entity.address,
      );
      final res = await datasource.updateCadre(id: id, model: model);
      return Right(res);
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

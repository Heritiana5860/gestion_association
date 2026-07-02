import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/dio_exception_mapper.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/datasources/president_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/models/president_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/president_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/repositories/president_repository.dart';

class PresidentRepositoryImpl implements PresidentRepository {
  final PresidentDatasource datasource;

  const PresidentRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, void>> addPresident(PresidentEntity entity) async {
    try {
      final model = PresidentModel(
        nom: entity.nom,
        contact: entity.contact,
        year: entity.year,
        bio: entity.bio,
      );
      final res = await datasource.addPresident(model);
      return Right(res);
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PresidentEntity>>> presidents() async {
    try {
      final res = await datasource.presidents();
      return Right(res);
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updatePresident({
    required int id,
    required PresidentEntity entity,
  }) async {
    try {
      final model = PresidentModel(
        nom: entity.nom,
        contact: entity.contact,
        year: entity.year,
        bio: entity.bio,
      );
      final res = await datasource.updatePresident(id: id, model: model);
      return Right(res);
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

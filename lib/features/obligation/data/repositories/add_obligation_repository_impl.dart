import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/dio_exception_mapper.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/data/datasources/add_obligation_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/data/models/obligation_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/domain/entities/obligation_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/domain/repositories/add_obligation_repository.dart';

class AddObligationRepositoryImpl implements AddObligationRepository {
  final AddObligationDatasource datasource;

  const AddObligationRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, void>> addObligation({
    required ObligationModel model,
  }) async {
    try {
      final response = await datasource.createObligation(model: model);
      return Right(response);
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ObligationEntity>>> fetchObligation() async {
    try {
      final response = await datasource.allObligations();
      return Right(response);
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

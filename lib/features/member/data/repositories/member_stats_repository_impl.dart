import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/dio_exception_mapper.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/data/datasources/member_stats_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_stats_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/repositories/member_stats_repository.dart';

class MemberStatsRepositoryImpl implements MemberStatsRepository {
  final MemberStatsDatasource datasource;

  const MemberStatsRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, MemberStatsEntity>> memberStats() async {
    try {
      final response = await datasource.stats();
      return Right(response);
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

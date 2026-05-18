import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/data/datasources/cotisation_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/entities/cotisation_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/repositories/cotisation_repository.dart';

class CotisationRepositoryImpl implements CotisationRepository {
  final CotisationDatasource datasource;

  const CotisationRepositoryImpl({required this.datasource});

  @override
  Future<List<CotisationEntity>> fetchCotisation() {
    return datasource.cotisation();
  }
}

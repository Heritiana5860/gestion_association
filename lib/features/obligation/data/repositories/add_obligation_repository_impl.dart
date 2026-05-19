import 'package:login_with_unite_test_and_clean_architecture/features/obligation/data/datasources/add_obligation_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/data/models/obligation_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/domain/entities/obligation_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/domain/repositories/add_obligation_repository.dart';

class AddObligationRepositoryImpl implements AddObligationRepository {
  final AddObligationDatasource datasource;

  const AddObligationRepositoryImpl({required this.datasource});

  @override
  Future<void> addObligation({required ObligationModel model}) async {
    await datasource.createObligation(model: model);
  }

  @override
  Future<List<ObligationEntity>> fetchObligation() {
    return datasource.allObligations();
  }
}

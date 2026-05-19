import 'package:login_with_unite_test_and_clean_architecture/features/obligation/data/models/obligation_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/domain/entities/obligation_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/domain/repositories/add_obligation_repository.dart';

class AddObligationUsecase {
  final AddObligationRepository repository;

  const AddObligationUsecase({required this.repository});

  Future<void> callAdd({required ObligationModel model}) {
    return repository.addObligation(model: model);
  }

  Future<List<ObligationEntity>> call() {
    return repository.fetchObligation();
  }
}

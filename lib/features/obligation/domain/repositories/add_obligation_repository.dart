import 'package:login_with_unite_test_and_clean_architecture/features/obligation/data/models/obligation_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/domain/entities/obligation_entity.dart';

abstract class AddObligationRepository {
  Future<void> addObligation({required ObligationModel model});
  Future<List<ObligationEntity>> fetchObligation();
}

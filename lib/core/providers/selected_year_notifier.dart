import 'package:flutter_riverpod/legacy.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/services/local_storage_service.dart';

class SelectedYearNotifier extends StateNotifier<String?> {
  final LocalStorageService _storageService = LocalStorageService();

  SelectedYearNotifier() : super(null) {
    _loadSavedYear();
  }

  // Charge l'année depuis les préférences au démarrage
  Future<void> _loadSavedYear() async {
    final savedYear = await _storageService.getSelectedYear();
    if (savedYear != null) {
      state = savedYear;
    }
  }

  // Change l'année et la sauvegarde localement
  Future<void> changeYear(String year) async {
    state = year;
    await _storageService.saveSelectedYear(year);
  }
}

// Le provider global à utiliser dans l'UI
final selectedYearProvider =
    StateNotifierProvider<SelectedYearNotifier, String?>((ref) {
      return SelectedYearNotifier();
    });

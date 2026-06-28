import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const _selectedYearKey = 'selected_year';

  // Sauvegarder l'année
  Future<void> saveSelectedYear(String year) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedYearKey, year);
  }

  // Récupérer l'année sauvegardée
  Future<String?> getSelectedYear() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_selectedYearKey);
  }
}

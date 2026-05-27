// "2025-06-15" → "15/06/2025"
String formatDate(String date) {
  try {
    final d = DateTime.parse(date);
    return "${d.day.toString().padLeft(2, '0')}/"
        "${d.month.toString().padLeft(2, '0')}/"
        "${d.year}";
  } catch (_) {
    return date;
  }
}

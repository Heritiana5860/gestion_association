// "2025-06-15T14:00:00" → "14:00"
String formatTime(String dateTime) {
  try {
    final dt = DateTime.parse(dateTime);
    return "${dt.hour.toString().padLeft(2, '0')}:"
        "${dt.minute.toString().padLeft(2, '0')}";
  } catch (_) {
    return dateTime;
  }
}

String formatTime(String dateTime) {
  try {
    final dt = DateTime.parse(dateTime).toLocal();
    return "${dt.hour.toString().padLeft(2, '0')}:"
        "${dt.minute.toString().padLeft(2, '0')}";
  } catch (_) {
    return dateTime;
  }
}

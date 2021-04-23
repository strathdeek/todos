extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  DateTime endOfDay() {
    return DateTime(year, month, day, 24);
  }

  DateTime startOfDay() {
    return DateTime(year, month, day, 0);
  }
}

extension StringExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

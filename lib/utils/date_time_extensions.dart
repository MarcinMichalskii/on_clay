extension IsSameDay on DateTime {
  bool isSameDay(DateTime other) {
    final isSameDay =
        year == other.year && month == other.month && day == other.day;
    return isSameDay;
  }
}

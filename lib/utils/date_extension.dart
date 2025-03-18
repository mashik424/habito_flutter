extension DateTimeExt on DateTime {
  DateTime get normalizedDate => DateTime(year, month, day);

  DateTime getStartOfWeek({int offsetWeeks = 0}) {
    var date = this;
    // Add offset weeks
    date = date.add(Duration(days: offsetWeeks * 7));

    // Calculate the difference from Monday
    final difference = date.weekday - DateTime.monday;

    // Adjust date to the Monday of the week
    final monday = date.subtract(Duration(days: difference));

    // Return date with time reset to midnight
    return DateTime(monday.year, monday.month, monday.day);
  }

  DateTime get endOfWeek {
    return getStartOfWeek().add(const Duration(days: 6));
  }

  DateTime getDateForWeekAndDay(int dayIndex) {
    return getStartOfWeek().add(Duration(days: dayIndex));
  }
}

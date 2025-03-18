import 'package:hive/hive.dart';

part 'habit_date.g.dart';

@HiveType(typeId: 1)
class HabitDate {
  HabitDate({required this.id, required this.habitId, required this.date});

  @HiveField(0)
  final String habitId;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final String id;
}

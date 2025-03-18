import 'package:get/get.dart';
import 'package:habito_flutter/hive/models/habit_date/habit_date.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class HabitDateBox {
  HabitDateBox._internal();

  static const String _boxName = 'habit_dates';
  static final HabitDateBox _instance = HabitDateBox._internal();

  static Future<HabitDateBox> init() async {
    Hive.registerAdapter(HabitDateAdapter());
    await Hive.openBox<HabitDate>(_boxName);
    return _instance;
  }

  Box<HabitDate> get _habitDatesBox {
    return Hive.box<HabitDate>(_boxName);
  }

  List<HabitDate> getAllHabitDates() {
    return _habitDatesBox.values.toList();
  }

  List<HabitDate> getAllDatesOfHabit({required String habitId}) {
    return _habitDatesBox.values
        .where((habitDate) => habitDate.habitId == habitId)
        .toList();
  }

  Future<void> addHabitDate({
    required DateTime date,
    required String habitId,
  }) async {
    final id = const Uuid().v4();
    await _habitDatesBox.put(
      id,
      HabitDate(habitId: habitId, date: date, id: id),
    );
  }

  Future<void> deleteHabitDate({
    required DateTime date,
    required String habitId,
  }) async {
    final habitDate = _habitDatesBox.values.toList().firstWhereOrNull(
      (habitDate) => habitDate.date == date && habitDate.habitId == habitId,
    );
    if (habitDate == null) return;
    await _habitDatesBox.delete(habitDate.id);
  }

  Future<void> deleteHabitDateWithId({required int id}) async {
    await _habitDatesBox.delete(id);
  }

  Future<bool> isHabitCompleted({
    required DateTime date,
    required String habitId,
  }) async {
    final habitDate = _habitDatesBox.values.toList().firstWhereOrNull(
      (habitDate) => habitDate.date == date && habitDate.habitId == habitId,
    );
    return habitDate != null;
  }

  void deleteAllHabitDates() {
    _habitDatesBox.clear();
  }

  HabitDate? getHabitDateById({required int id}) {
    return _habitDatesBox.get(id);
  }
}

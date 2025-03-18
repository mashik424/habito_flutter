import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_flutter/hive/boxes/habit_box.dart';
import 'package:habito_flutter/hive/boxes/habit_date_box.dart';
import 'package:habito_flutter/hive/models/habit/habit.dart';
import 'package:habito_flutter/hive/models/habit_date/habit_date.dart';
import 'package:habito_flutter/utils/date_extension.dart';

class HabitsController extends GetxController {
  HabitsController({
    required HabitBox habitBox,
    required HabitDateBox habitDateBox,
  }) : _habitBox = habitBox,
       _habitDateBox = habitDateBox;

  final HabitBox _habitBox;
  final HabitDateBox _habitDateBox;

  final habits = <Habit>[].obs;

  @override
  void onInit() {
    super.onInit();
    _fetchAllhabits();
  }

  void _fetchAllhabits() {
    final list = _habitBox.getAllHabits();
    habits.assignAll(list);
  }

  Future<void> createHabit({
    required String title,
    required String desc,
    required Color color,
    VoidCallback? onComplete,
    ValueChanged<Exception>? onError,
  }) async {
    try {
      final habit = await _habitBox.addHabit(
        title: title,
        description: desc,
        color: color,
      );
      onComplete?.call();
      habits.add(habit);
    } on Exception catch (e) {
      onError?.call(e);
    }
  }

  Future<void> deleteHabit(
    String id, {
    VoidCallback? onComplete,
    ValueChanged<Exception>? onError,
  }) async {
    try {
      await _habitBox.deleteHabit(id: id);
      onComplete?.call();
      habits.removeWhere((element) => element.id == id);
    } on Exception catch (e) {
      onError?.call(e);
    }
  }

  Future<void> updateHabit({
    required Habit habit,
    VoidCallback? onComplete,
    ValueChanged<Exception>? onError,
  }) async {
    try {
      final updatedHabit = await _habitBox.updateHabit(habit: habit);
      onComplete?.call();
      habits
        ..removeWhere((element) => element.id == habit.id)
        ..add(updatedHabit);
    } on Exception catch (e) {
      onError?.call(e);
    }
  }

  Future<void> completeHabit({
    required String habitId,
    DateTime? date,
    VoidCallback? onComplete,
    ValueChanged<Exception>? onError,
  }) async {
    try {
      await _habitDateBox.addHabitDate(
        habitId: habitId,
        date: (date ?? DateTime.now()).normalizedDate,
      );
      onComplete?.call();
    } on Exception catch (e) {
      onError?.call(e);
    }
  }

  Future<void> uncompleteHabit({
    required String habitId,
    required DateTime date,
    VoidCallback? onComplete,
    ValueChanged<Exception>? onError,
  }) async {
    try {
      await _habitDateBox.deleteHabitDate(
        habitId: habitId,
        date: date.normalizedDate,
      );
      onComplete?.call();
    } on Exception catch (e) {
      onError?.call(e);
    }
  }

  Future<bool> isHabitCompleted({
    required String habitId,
    required DateTime date,
  }) async {
    return _habitDateBox.isHabitCompleted(
      habitId: habitId,
      date: date.normalizedDate,
    );
  }

  List<HabitDate> fetchHabitDates(String habitId) {
    return _habitDateBox.getAllDatesOfHabit(habitId: habitId);
  }
}

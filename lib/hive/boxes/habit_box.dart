import 'package:flutter/material.dart';
import 'package:habito_flutter/hive/models/habit/habit.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class ColorAdapter extends TypeAdapter<Color> {
  @override
  final int typeId = 2;

  @override
  Color read(BinaryReader reader) {
    return Color(reader.readInt());
  }

  @override
  void write(BinaryWriter writer, Color obj) {
    writer.writeInt(obj.toARGB32());
  }
}

class HabitBox {
  HabitBox._internal();

  static const String _boxName = 'habits';
  static final HabitBox _instance = HabitBox._internal();

  static Future<HabitBox> init() async {
    Hive
      ..registerAdapter(HabitAdapter())
      ..registerAdapter(ColorAdapter());
    await Hive.openBox<Habit>(_boxName);
    return _instance;
  }

  Box<Habit> get _habitsBox {
    return Hive.box<Habit>(_boxName);
  }

  List<Habit> getAllHabits() {
    return _habitsBox.values.toList();
  }

  Future<Habit> addHabit({
    required String title,
    required String description,
    required Color color,
  }) async {
    final id = const Uuid().v4();
    final habit = Habit(
      id: id,
      title: title,
      description: description,
      color: color,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await _habitsBox.put(id, habit);
    return habit;
  }

  Future<Habit> updateHabit({required Habit habit}) async {
    final updatedHabit = habit.copyWith(updatedAt: DateTime.now());
    await _habitsBox.put(habit.id, updatedHabit);
    return updatedHabit;
  }

  Future<void> deleteHabit({required String id}) async {
    await _habitsBox.delete(id);
  }

  void deleteAllHabits() {
    _habitsBox.clear();
  }

  Habit? getHabitById({required String id}) {
    return _habitsBox.get(id);
  }
}

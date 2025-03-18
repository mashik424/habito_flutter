import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_flutter/controllers/habits_controller.dart';
import 'package:habito_flutter/screens/create_habit_screen.dart';
import 'package:habito_flutter/screens/home_screen/habit_item.dart';

const String homeRoute = '/home';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HabitsController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Hablts')),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.habits.length,
          padding: const EdgeInsets.all(8),
          itemBuilder:
              (context, index) => HabitItem(habit: controller.habits[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed<dynamic>(createHabitRoute),
        child: const Icon(Icons.add),
      ),
    );
  }
}

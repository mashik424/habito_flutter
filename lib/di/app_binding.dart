import 'package:get/get.dart';
import 'package:habito_flutter/controllers/habits_controller.dart';
import 'package:habito_flutter/hive/boxes/habit_box.dart';
import 'package:habito_flutter/hive/boxes/habit_date_box.dart';

class AppBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    await Get.putAsync(HabitBox.init, permanent: true);
    await Get.putAsync(HabitDateBox.init, permanent: true);
    Get.put(
      HabitsController(
        habitBox: Get.find<HabitBox>(),
        habitDateBox: Get.find<HabitDateBox>(),
      ),
      permanent: true,
    );
  }
}

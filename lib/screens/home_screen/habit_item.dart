import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:habito_flutter/controllers/habits_controller.dart';
import 'package:habito_flutter/hive/models/habit/habit.dart';
import 'package:habito_flutter/screens/create_habit_screen.dart';
import 'package:habito_flutter/screens/home_screen/date_grid.dart';
import 'package:habito_flutter/utils/date_extension.dart';

class HabitItem extends StatefulWidget {
  const HabitItem({required this.habit, super.key});

  final Habit habit;

  @override
  State<HabitItem> createState() => _HabitItemState();
}

class _HabitItemState extends State<HabitItem> {
  final _controller = Get.find<HabitsController>();
  bool _completedToday = false;

  String get _habitId => widget.habit.id;
  final List<int> _dates = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _completedToday = await _controller.isHabitCompleted(
        habitId: widget.habit.id,
        date: DateTime.now(),
      );
      setState(() {});

      final dates = _controller.fetchHabitDates(_habitId);
      _dates.addAll(dates.map((e) => e.date.millisecondsSinceEpoch));
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(widget.habit.title),
              ),
              _buttonRow,
            ],
          ),
          const Gap(4),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ).copyWith(bottom: 8),
            child: DatesGrid(color: widget.habit.color, dates: _dates),
          ),
        ],
      ),
    );
  }

  Widget get _buttonRow {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () {
            _controller.deleteHabit(
              widget.habit.id,
              onError: (value) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(value.toString())));
              },
            );
          },
          icon: const Icon(Icons.delete),
        ),
        IconButton(
          onPressed: () {
            Get.toNamed<dynamic>(createHabitRoute, arguments: widget.habit);
          },
          icon: const Icon(Icons.edit),
        ),
        IconButton.filledTonal(
          onPressed: () {
            if (_completedToday) {
              _controller.uncompleteHabit(
                habitId: _habitId,
                date: DateTime.now(),
                onComplete: () {
                  _dates.remove(
                    DateTime.now().normalizedDate.millisecondsSinceEpoch,
                  );
                  setState(() => _completedToday = false);
                },
              );
            } else {
              _controller.completeHabit(
                habitId: _habitId,
                date: DateTime.now(),
                onComplete: () {
                  _dates.add(
                    DateTime.now().normalizedDate.millisecondsSinceEpoch,
                  );
                  setState(() => _completedToday = true);
                },
              );
            }
          },

          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: widget.habit.color.withAlpha(
              ((_completedToday ? 1.0 : 0.1) * 255).round(),
            ),
            foregroundColor: _completedToday ? Colors.white : Colors.black,
            padding: EdgeInsets.zero,
          ),
          icon: const Icon(Icons.check),
        ),
      ],
    );
  }
}

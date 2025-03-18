import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:habito_flutter/controllers/habits_controller.dart';
import 'package:habito_flutter/di/empty_binding.dart';
import 'package:habito_flutter/hive/models/habit/habit.dart';

const String createHabitRoute = '/create-habit';

class CreateHabitScreen extends StatefulWidget {
  const CreateHabitScreen({this.habit, super.key});

  final Habit? habit;

  @override
  State<CreateHabitScreen> createState() => _CreateHabitScreenState();
}

class _CreateHabitScreenState extends State<CreateHabitScreen> {
  Color _color = Colors.teal;
  final _formKey = GlobalKey<FormState>();
  late final HabitsController habitsController;

  late List<TextEditingController> _controllers;

  @override
  void initState() {
    habitsController = Get.find<HabitsController>();
    if (widget.habit != null) {
      _color = widget.habit!.color;
      _controllers = [
        TextEditingController(text: widget.habit!.title),
        TextEditingController(text: widget.habit!.description),
      ];
    } else {
      _controllers = [TextEditingController(), TextEditingController()];
    }

    Get.find<SomeClass>().someMethod();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.habit == null ? 'Create' : 'Edit'} Habit'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: const InputDecoration(label: Text('Title')),
                textCapitalization: TextCapitalization.words,
                controller: _controllers[0],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const Gap(16),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Description'),
                  alignLabelWithHint: true,
                ),
                controller: _controllers[1],
                minLines: 4,
                maxLines: 6,
                textCapitalization: TextCapitalization.sentences,
              ),
              const Gap(16),
              TextButton(
                onPressed: () async {
                  // raise the [showDialog] widget
                  await showDialog<dynamic>(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                          title: const Text('Pick a color!'),
                          content: SingleChildScrollView(
                            child: BlockPicker(
                              pickerColor: _color,
                              onColorChanged:
                                  (color) => setState(() => _color = color),
                            ),
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              child: const Text('Got it'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                        color: _color,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const Gap(8),
                    const Text('Pick Color'),
                  ],
                ),
              ),
              const Gap(36),
              ElevatedButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;
                  if (widget.habit != null) {
                    habitsController.updateHabit(
                      habit: widget.habit!.copyWith(
                        title: _controllers[0].text,
                        description: _controllers[1].text,
                        color: _color,
                      ),
                      onComplete: Get.back<dynamic>,
                      onError: (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(error.toString())),
                        );
                      },
                    );
                    return;
                  }
                  habitsController.createHabit(
                    title: _controllers[0].text,
                    desc: _controllers[1].text,
                    color: _color,
                    onComplete: Get.back<dynamic>,
                    onError: (error) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(error.toString())));
                    },
                  );
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

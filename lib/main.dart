import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_flutter/di/app_binding.dart';
import 'package:habito_flutter/hive/models/habit/habit.dart';
import 'package:habito_flutter/middlewares/prevent_back_middleware.dart';
import 'package:habito_flutter/screens/create_habit_screen.dart';
import 'package:habito_flutter/screens/home_screen/home_screen.dart';
import 'package:habito_flutter/screens/splash_screen.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Habito',
      theme: ThemeData.light().copyWith(
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      initialRoute: '/',
      initialBinding: AppBinding(),

      onGenerateRoute: (settings) {
        switch (settings.name) {
          case homeRoute:
            return GetPageRoute(
              routeName: settings.name,
              page: () => const HomeScreen(),
            );
          case createHabitRoute:
            final habit = settings.arguments as Habit?;
            return GetPageRoute(
              routeName: settings.name,
              page: () => CreateHabitScreen(habit: habit),
              middlewares: [CustomBindingMiddleware()],
            );
          default:
            return GetPageRoute(
              routeName: settings.name,
              page: () => const SplashScreen(),
            );
        }
      },
    );
  }
}

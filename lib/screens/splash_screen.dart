import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_flutter/screens/home_screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initializeDependencies();
  }

  Future<void> initializeDependencies() async {
    await Future.delayed(
      const Duration(seconds: 2),
      () => Get.offNamed<dynamic>(homeRoute),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          Text(
            'Habito',
            style: Theme.of(context).textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
          const Spacer(flex: 3),
          const Center(child: CircularProgressIndicator()),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}

import 'package:get/get.dart';

class EmptyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SomeClass());
  }
}

class SomeClass {
  void someMethod() {
    print('Some method called');
  }
}

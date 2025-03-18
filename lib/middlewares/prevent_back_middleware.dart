import 'package:get/get.dart';
import 'package:habito_flutter/di/empty_binding.dart';

class CustomBindingMiddleware extends GetMiddleware {
  @override
  List<Bindings>? onBindingsStart(List<Bindings>? bindings) {
    bindings?.add(EmptyBinding()); // Add extra bindings dynamically
    return bindings;
  }
}

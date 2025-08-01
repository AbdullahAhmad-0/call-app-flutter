import 'package:get/get.dart';
import 'package:kasookoo_sdk/controllers/home_controller.dart';
import 'package:kasookoo_sdk/controllers/call_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<CallController>(() => CallController());
  }
}
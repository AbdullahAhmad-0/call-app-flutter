import 'package:get/get.dart';
import 'package:call_app/controllers/home_controller.dart';
import 'package:call_app/controllers/call_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<CallController>(() => CallController());
  }
}
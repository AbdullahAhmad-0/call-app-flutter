import 'package:get/get.dart';
import 'package:call_app/controllers/app_controller.dart';
import 'package:call_app/routes/app_routes.dart';

class HomeController extends GetxController {
  final AppController appController = AppController.to;

  void navigateToCallHistory() {
    Get.toNamed(Routes.CALL_HISTORY);
  }

  void callDriver() {
    Get.toNamed(Routes.CALLING, arguments: {
      'callType': 'Driver',
      'callerName': 'Driver',
      'isOutgoing': true,
    });
  }

  void callSupport() {
    Get.toNamed(Routes.CALLING, arguments: {
      'callType': 'Support',
      'callerName': 'Support',
      'isOutgoing': true,
    });
  }

  void simulateIncomingCall() {
    Get.toNamed(Routes.RINGING, arguments: {
      'callType': 'Customer',
      'callerName': 'Customer',
      'isIncoming': true,
    });
  }
}
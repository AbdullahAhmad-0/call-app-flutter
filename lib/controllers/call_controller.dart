import 'package:get/get.dart';
import 'package:call_app/controllers/app_controller.dart';
import 'package:call_app/models/call_history.dart';
import 'package:call_app/services/api_service.dart';
import 'package:call_app/routes/app_routes.dart';
import 'dart:async';

class CallController extends GetxController {
  final ApiService apiService = Get.put(ApiService());
  final AppController appController = AppController.to;

  var isConnected = false.obs;
  var callDuration = 0.obs;
  var callStatus = 'Calling...'.obs;

  Timer? _timer;
  String? currentCallId;
  String? currentRoomName;

  void startCall(String callType, String callerName, bool isOutgoing) {
    currentCallId = DateTime.now().millisecondsSinceEpoch.toString();
    currentRoomName = 'sdk-room-${currentCallId}';

    if (isOutgoing) {
      callStatus.value = 'Calling $callType...';
      _simulateConnection();
    } else {
      callStatus.value = '$callerName is calling...';
    }
  }

  void answerCall() {
    isConnected.value = true;
    callStatus.value = 'Connected...';
    _startTimer();
    Get.offNamed(Routes.CALLING);
  }

  void endCall() {
    _endCallLogic();
  }

  void declineCall() {
    _endCallLogic();
  }

  void _simulateConnection() {
    Future.delayed(Duration(seconds: 2), () {
      if (!isConnected.value) {
        isConnected.value = true;
        callStatus.value = 'Connected...';
        _startTimer();
      }
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      callDuration.value++;
    });
  }

  void _endCallLogic() {
    _timer?.cancel();

    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final callType = args['callType'] ?? 'Unknown';
    final callerName = args['callerName'] ?? 'Unknown';
    final isIncoming = args['isIncoming'] ?? false;

    final duration = _formatDuration(callDuration.value);

    appController.addCallHistory(
      CallHistory(
        id: currentCallId ?? DateTime.now().millisecondsSinceEpoch.toString(),
        callerName: callerName,
        callType: callType,
        timestamp: DateTime.now(),
        duration: duration,
        isIncoming: isIncoming,
      ),
    );

    callDuration.value = 0;
    isConnected.value = false;
    callStatus.value = '';

    Get.back();
  }

  String _formatDuration(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}

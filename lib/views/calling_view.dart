import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:call_app/components/gradient_background.dart';
import 'package:call_app/components/call_avatar.dart';
import 'package:call_app/components/action_button.dart';
import 'package:call_app/controllers/call_controller.dart';

class CallingView extends GetView<CallController> {
  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final callType = args['callType'] ?? 'Unknown';
    final callerName = args['callerName'] ?? 'Unknown';
    final isOutgoing = args['isOutgoing'] ?? true;

    controller.startCall(callType, callerName, isOutgoing);

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                AppBar(
                  title: Text('Kasookoo SDK'),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: Container(),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CallAvatar(callType: callType),
                      SizedBox(height: 40),
                      Text(
                        callerName,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(() => Text(
                        controller.callStatus.value,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      )),
                      SizedBox(height: 10),
                      Obx(() => controller.isConnected.value
                          ? Text(
                        'Waiting for other participant',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white54,
                        ),
                      )
                          : SizedBox()),
                      SizedBox(height: 20),
                      Obx(() => controller.callDuration.value > 0
                          ? Text(
                        _formatDuration(controller.callDuration.value),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      )
                          : SizedBox()),
                    ],
                  ),
                ),
                _buildActionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Obx(() {
      if (controller.isConnected.value) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ActionButton(
              icon: Icons.call,
              backgroundColor: Colors.green,
              onPressed: () {},
            ),
            ActionButton(
              icon: Icons.call_end,
              backgroundColor: Colors.red,
              onPressed: controller.endCall,
            ),
          ],
        );
      } else {
        return ActionButton(
          icon: Icons.call_end,
          backgroundColor: Colors.red,
          onPressed: controller.endCall,
        );
      }
    });
  }

  String _formatDuration(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}

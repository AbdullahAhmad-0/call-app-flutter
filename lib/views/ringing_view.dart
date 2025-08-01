import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:call_app/components/gradient_background.dart';
import 'package:call_app/components/call_avatar.dart';
import 'package:call_app/components/action_button.dart';
import 'package:call_app/controllers/call_controller.dart';

class RingingView extends GetView<CallController> {
  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final callType = args['callType'] ?? 'Unknown';
    final callerName = args['callerName'] ?? 'Unknown';
    final isIncoming = args['isIncoming'] ?? true;

    controller.startCall(callType, callerName, !isIncoming);

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
                      _buildPulsingAvatar(callType),
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
                      Text(
                        'Incoming Call',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '$callerName is calling...',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white54,
                        ),
                      ),
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

  Widget _buildPulsingAvatar(String callType) {
    return TweenAnimationBuilder(
      duration: Duration(seconds: 1),
      tween: Tween<double>(begin: 0.8, end: 1.2),
      builder: (context, double scale, child) {
        return Transform.scale(
          scale: scale,
          child: CallAvatar(callType: callType),
        );
      },
      onEnd: () {},
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ActionButton(
          icon: Icons.call,
          backgroundColor: Colors.green,
          onPressed: controller.answerCall,
          size: 70,
        ),
        ActionButton(
          icon: Icons.call_end,
          backgroundColor: Colors.red,
          onPressed: controller.declineCall,
          size: 70,
        ),
      ],
    );
  }
}
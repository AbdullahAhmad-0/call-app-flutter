import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:call_app/components/gradient_background.dart';
import 'package:call_app/controllers/app_controller.dart';
import 'package:call_app/models/call_history.dart';

class CallHistoryView extends StatelessWidget {
  final AppController controller = AppController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(),
              Expanded(
                child: Obx(() {
                  if (controller.callHistory.isEmpty) {
                    return _buildEmptyState();
                  }
                  return _buildHistoryList();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.8),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back, color: Colors.white),
          ),
          Text(
            'Call History',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Spacer(),
          IconButton(
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  title: Text('Clear History'),
                  content: Text('Are you sure you want to clear all call history?'),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.clearCallHistory();
                        Get.back();
                      },
                      child: Text('Clear'),
                    ),
                  ],
                ),
              );
            },
            icon: Icon(Icons.clear_all, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.call,
            size: 80,
            color: Colors.white54,
          ),
          SizedBox(height: 20),
          Text(
            'No call history yet',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList() {
    return ListView.builder(
      padding: EdgeInsets.all(20),
      itemCount: controller.callHistory.length,
      itemBuilder: (context, index) {
        CallHistory call = controller.callHistory[index];
        return _buildHistoryItem(call);
      },
    );
  }

  Widget _buildHistoryItem(CallHistory call) {
    IconData icon;
    Color iconColor;

    switch (call.callType.toLowerCase()) {
      case 'driver':
        icon = Icons.directions_car;
        iconColor = Colors.blue;
        break;
      case 'support':
        icon = Icons.headset_mic;
        iconColor = Colors.green;
        break;
      case 'customer':
        icon = Icons.person;
        iconColor = Colors.orange;
        break;
      default:
        icon = Icons.call;
        iconColor = Colors.grey;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  call.callerName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '${call.callType} Call',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatDate(call.timestamp),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
              ),
              SizedBox(height: 4),
              Text(
                call.duration,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}, ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
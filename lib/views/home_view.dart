import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:call_app/components/gradient_background.dart';
import 'package:call_app/components/call_button.dart';
import 'package:call_app/controllers/home_controller.dart';
import 'package:call_app/controllers/app_controller.dart';

class HomeView extends GetView<HomeController> {
  final AppController appController = AppController.to;

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
                  String role = appController.userRole.value;
                  if (role == 'DRIVER') {
                    return _buildDriverView();
                  } else {
                    return _buildCustomerView();
                  }
                }),
              ),
              _buildStatusBar(),
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
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: Row(
        children: [
          Icon(Icons.phone, color: Colors.white, size: 24),
          SizedBox(width: 10),
          Text(
            'Kasookoo SDK',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Spacer(),
          IconButton(
            onPressed: controller.navigateToCallHistory,
            icon: Icon(Icons.history, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildDriverView() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(height: 40),
          Text(
            'Driver Mode',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Available - Waiting for calls',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
          SizedBox(height: 40),
          CallButton(
            title: 'Call Your Driver',
            subtitle: 'Connect instantly with your assigned driver',
            icon: Icons.directions_car,
            iconColor: Colors.blue,
            buttonText: 'Simulate Incoming Call',
            onButtonTap: controller.simulateIncomingCall,
          ),
          CallButton(
            title: 'Call Support',
            subtitle: 'Get instant help from our support team',
            icon: Icons.headset_mic,
            iconColor: Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerView() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(height: 40),
          Text(
            'Welcome Customer!',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Choose who to call:',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
          SizedBox(height: 40),
          CallButton(
            title: 'Call Your Driver',
            subtitle: 'Connect instantly with your assigned driver',
            icon: Icons.directions_car,
            iconColor: Colors.blue,
            buttonText: 'Call Driver Now',
            onButtonTap: controller.callDriver,
          ),
          CallButton(
            title: 'Call Support',
            subtitle: 'Get instant help from our support team',
            icon: Icons.headset_mic,
            iconColor: Colors.green,
            buttonText: 'Call Support',
            onButtonTap: controller.callSupport,
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBar() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green,
            ),
          ),
          SizedBox(width: 8),
          Text(
            'Online • Ready to connect',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:call_app/components/gradient_background.dart';
import 'package:call_app/controllers/app_controller.dart';
import 'package:call_app/routes/app_routes.dart';

class RoleSelectionView extends StatelessWidget {
  final AppController controller = AppController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                title: Text('Kasookoo SDK'),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.phone,
                        size: 80,
                        color: Colors.blue,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Kasookoo SDK Demo',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Select your role to continue',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: 60),
                      _buildRoleButton(
                        'I\'m a Customer',
                        'CUSTOMER',
                        Colors.blue,
                      ),
                      SizedBox(height: 20),
                      _buildRoleButton(
                        'I\'m a Driver',
                        'DRIVER',
                        Colors.transparent,
                        borderColor: Colors.blue,
                        textColor: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleButton(
      String text,
      String role,
      Color backgroundColor, {
        Color? borderColor,
        Color? textColor,
      }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          controller.setUserRole(role);
          Get.offAllNamed(Routes.HOME);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor ?? Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: borderColor != null
                ? BorderSide(color: borderColor, width: 2)
                : BorderSide.none,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

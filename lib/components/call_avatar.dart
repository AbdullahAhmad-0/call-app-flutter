import 'package:flutter/material.dart';

class CallAvatar extends StatelessWidget {
  final String callType;
  final double size;

  const CallAvatar({
    Key? key,
    required this.callType,
    this.size = 120,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;

    switch (callType.toLowerCase()) {
      case 'driver':
        icon = Icons.directions_car;
        color = Colors.blue;
        break;
      case 'support':
        icon = Icons.headset_mic;
        color = Colors.green;
        break;
      case 'customer':
        icon = Icons.person;
        color = Colors.orange;
        break;
      default:
        icon = Icons.person;
        color = Colors.grey;
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Icon(
        icon,
        size: size * 0.4,
        color: color,
      ),
    );
  }
}
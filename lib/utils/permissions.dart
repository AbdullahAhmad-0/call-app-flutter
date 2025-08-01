import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<bool> requestCallPermissions() async {
    Map<Permission, PermissionStatus> permissions = await [
      Permission.camera,
      Permission.microphone,
      Permission.notification,
    ].request();

    return permissions.values.every((status) => status.isGranted);
  }

  static Future<bool> hasCallPermissions() async {
    return await Permission.camera.isGranted &&
        await Permission.microphone.isGranted &&
        await Permission.notification.isGranted;
  }
}
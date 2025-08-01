import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:call_app/routes/app_routes.dart';

class NotificationService extends GetxService {
  late FirebaseMessaging _messaging;
  late FlutterLocalNotificationsPlugin _localNotifications;

  Future<NotificationService> init() async {
    _messaging = FirebaseMessaging.instance;
    _localNotifications = FlutterLocalNotificationsPlugin();

    await _setupLocalNotifications();
    await _setupFirebaseMessaging();

    return this;
  }

  Future<void> _setupLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    const androidChannel = AndroidNotificationChannel(
      'call_notification_channel',
      'Call Notifications',
      description: 'Notifications for incoming calls',
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);
  }

  Future<void> _setupFirebaseMessaging() async {
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

    String? token = await _messaging.getToken();
    print('FCM Token: $token');
  }

  void _handleForegroundMessage(RemoteMessage message) {
    if (message.data['type'] == 'incoming_call') {
      _showIncomingCallNotification(message.data); // here is i got error
    }
  }

  void _handleMessageOpenedApp(RemoteMessage message) {
    if (message.data['type'] == 'incoming_call') {
      Get.toNamed(Routes.RINGING, arguments: {
        'callType': message.data['call_type'] ?? 'Unknown',
        'callerName': message.data['caller_name'] ?? 'Unknown',
        'callId': message.data['call_id'] ?? '',
        'token': message.data['livekit_token'] ?? '',
        'roomName': message.data['room_name'] ?? '',
        'isIncoming': true,
      });
    }
  }

  void _onNotificationTapped(NotificationResponse response) {
    if (response.actionId == 'answer') {
      Get.toNamed(Routes.CALLING);
    } else if (response.actionId == 'decline') {
      _dismissCallNotification();
    }
  }

    Future<void> _showIncomingCallNotification(Map<String, dynamic> data) async {
      const androidDetails = AndroidNotificationDetails(
      'call_notification_channel',
      'Call Notifications',
      channelDescription: 'Notifications for incoming calls',
      importance: Importance.high,
      priority: Priority.high,
      category: AndroidNotificationCategory.call,
      fullScreenIntent: true,
      actions: [
        AndroidNotificationAction('answer', 'Answer'),
        AndroidNotificationAction('decline', 'Decline'),
      ],
    );

    const iosDetails = DarwinNotificationDetails(
      categoryIdentifier: 'call_category',
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      1001,
      'Incoming Call',
      '${data['caller_name']} is calling...',
      details,
    );
  }

  void _dismissCallNotification() {
    _localNotifications.cancel(1001);
  }
}

@pragma('vm:entry-point')
Future<void> _handleBackgroundMessage(RemoteMessage message) async {
  print('Background message: ${message.messageId}');
}
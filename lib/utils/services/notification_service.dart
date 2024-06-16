import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';

class NotificationService {
  NotificationService._();

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_bas_app');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:
          backgroundNotificationResponseHandler,
    );
  }

  static void onDidReceiveNotificationResponse(NotificationResponse details) {
    if (details.payload != null) {
      OpenFile.open(details.payload);
    }
  }

  static void backgroundNotificationResponseHandler(
      NotificationResponse details) {
    if (details.payload != null) {
      OpenFile.open(details.payload);
    }
  }

  static Future<void> showNotification({
    required int notifId,
    required String filePath,
    required String fileName,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'download_channel',
      'Downloads',
      channelDescription: 'Channel for download notifications',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      notifId,
      'Download $fileName Complete',
      'Tap to open the file',
      platformChannelSpecifics,
      payload: filePath,
    );
  }
}

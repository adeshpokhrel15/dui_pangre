import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:two_wheelers/templates/screens/map_screen.dart';
import 'package:two_wheelers/templates/utils/app.dart';
import 'package:two_wheelers/templates/utils/notifiaction_service.dart';

Future<void> _firebaseMessengingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message: ${message.messageId}');
  if (message.notification != null) {
    print("Message also contained a notification: ${message.notification}");
    NotificationService.showNotification(
      title: message.notification!.title as String,
      body: message.notification!.body as String,
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  print(await messaging.getToken());

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print("Granted permissions:  ${settings.authorizationStatus}");

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print("Message data ${message.data}");

    if (message.notification != null) {
      print("Message also contained a notification: ${message.notification}");
      NotificationService.showNotification(
        title: message.notification!.title as String,
        body: message.notification!.body as String,
      );
    }
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessengingBackgroundHandler);
  await NotificationService.initializeNotification();
  runApp(const ProviderScope(child: MyApp()));
  // runApp(const ProviderScope(child: MapSample()));
}

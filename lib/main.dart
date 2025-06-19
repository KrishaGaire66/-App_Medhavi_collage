import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medhavi/firebase_options.dart';
import 'package:medhavi/hive/hive_service.dart';
import 'package:medhavi/routes/routes.dart';

import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await _saveNotificationToHive(message);
}

Future<void> _saveNotificationToHive(RemoteMessage message) async {
  final box = await Hive.openBox('noticesBox');
  final title = message.notification?.title ?? "No Title";
  final body = message.notification?.body ?? "No Description";
  final date = DateTime.now().toString().substring(0, 10);

  final notice = {"title": title, "date": date, "description": body};

  final List<dynamic> stored = box.get('notices', defaultValue: []);
  final notices =
      stored.map<Map<String, String>>((item) {
        final map = Map<String, dynamic>.from(item);
        return map.map((k, v) => MapEntry(k.toString(), v.toString()));
      }).toList();

  // Avoid saving duplicates
  bool exists = notices.any(
    (n) => n['title'] == title && n['date'] == date && n['description'] == body,
  );

  if (!exists) {
    notices.insert(0, notice);
    await box.put('notices', notices);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await Hive.initFlutter();
  await HiveService.init(); // Assuming this opens required boxes

  runZonedGuarded(
    () {
      runApp(ProviderScope(child: const MyApp()));
    },
    (error, stackTrace) {
      debugPrint('UNCAUGHT ERROR: $error\n$stackTrace');
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _setupFirebaseListeners();
  }

  void _setupFirebaseListeners() async {
    await FirebaseMessaging.instance.requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _saveNotificationToHive(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _saveNotificationToHive(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
      onGenerateRoute: Routes.onGenerateRouted,
    );
  }
}
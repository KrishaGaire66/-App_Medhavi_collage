import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medhavi/connectivity/example_internet_check.dart';
import 'package:medhavi/utils/colors.dart';



class NoticeScreen extends StatefulWidget {
  const NoticeScreen({super.key});

  @override
  State<NoticeScreen> createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  List<Map<String, String>> notices = [];
  final Set<String> _handledMessages = {};
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeLocalNotifications();
    _loadNoticesFromHive();
    _setupFirebaseMessaging();
  }

  void _initializeLocalNotifications() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);
    await flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  Future<void> _loadNoticesFromHive() async {
  await Hive.openBox('noticesBox'); // ✅ Now it's fine

  final box = Hive.box('noticesBox'); // You missed this in your snippet
  final storedNotices = box.get('notices', defaultValue: []) as List<dynamic>;

  final parsedNotices = storedNotices.map<Map<String, String>>((item) {
    final map = Map<String, dynamic>.from(item);
    return map.map((key, value) => MapEntry(key.toString(), value.toString()));
  }).toList();

  setState(() {
    notices = parsedNotices;
  });
}


  void _saveNoticeToHive(Map<String, String> notice) async {
    final box = Hive.box('noticesBox');
    final storedNotices = box.get('notices', defaultValue: []) as List<dynamic>;

    final newList = List<Map<String, String>>.from(storedNotices.map((item) {
      final map = Map<String, dynamic>.from(item);
      return map.map((k, v) => MapEntry(k.toString(), v.toString()));
    }));

    bool exists = newList.any((n) =>
        n['title'] == notice['title'] &&
        n['date'] == notice['date'] &&
        n['description'] == notice['description']);

    if (!exists) {
      newList.insert(0, notice);
      await box.put('notices', newList);
      print('Saved new notice: $notice');
    } else {
      print('Notice already exists.');
    }
  }

  void _setupFirebaseMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    String? token = await messaging.getToken();
    print("FCM Token: $token");

    NotificationSettings settings = await messaging.requestPermission();
    print("Permission: ${settings.authorizationStatus}");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Foreground message: ${message.notification?.title}");
      _handleMessage(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("App opened from background via notification");
      _handleMessage(message);
    });

    RemoteMessage? initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      print("App opened from terminated state");
      _handleMessage(initialMessage);
    }
  }

  void _showLocalNotification(String title, String body) async {
    const androidDetails = AndroidNotificationDetails(
      'notice_channel',
      'Notices',
      channelDescription: 'Channel for showing notice notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    const platformDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      platformDetails,
    );
  }

  void _handleMessage(RemoteMessage message) {
    String title = message.notification?.title ?? "Notice";
    String body = message.notification?.body ?? "You have a new notice.";
    String date = DateTime.now().toString().substring(0, 10);

    final newNotice = {"title": title, "date": date, "description": body};
    final noticeKey = "$title|$date|$body";

    if (_handledMessages.contains(noticeKey)) return;
    _handledMessages.add(noticeKey);

    if (!mounted) return;

    bool alreadyExists = notices.any((n) =>
        n['title'] == title &&
        n['date'] == date &&
        n['description'] == body);

    if (alreadyExists) return;

    setState(() {
      notices.insert(0, newNotice);
    });

    _saveNoticeToHive(newNotice);
    _showLocalNotification(title, body);
    _showDialog(title, body);
  }

  void _showDialog(String title, String body) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  Future<void> _refreshNotices() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _loadNoticesFromHive();
  }

  @override
  Widget build(BuildContext context) {
    return InternetHandler(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Notices'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient:linearGradient1),
          ),
          
        ),
        body: RefreshIndicator(
          onRefresh: _refreshNotices,
          child: notices.isEmpty
              ? const Center(child: Text("No notices available."))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: notices.length,
                  itemBuilder: (context, index) {
                    final notice = notices[index];
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notice["title"] ?? '',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              notice["date"] ?? '',
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              notice["description"] ?? '',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            final test = {
              "title": "Test Notice",
              "date": DateTime.now().toString().substring(0, 10),
              "description": "This is a local test notice"
            };
            _handleMessage(RemoteMessage(
              notification: RemoteNotification(
                title: test['title'],
                body: test['description'],
              ),
            ));
          },
        ),
      ),
    );
  }
}

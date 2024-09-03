import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../models/notification_model.dart';
import '../widgets/notification_item.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationsScreen> {
  List<NotificationModel> notifications = [];

  @override
  void initState() {
    super.initState();
    notifications = [
      NotificationModel(title: 'Notification 1', body: 'Subtitle 1'),
      NotificationModel(title: 'Notification 2', body: 'Subtitle 2'),
      NotificationModel(title: 'Notification 3', body: 'Subtitle 3'),
      NotificationModel(title: 'Notification 4', body: 'Subtitle 4'),
      NotificationModel(title: 'Notification 5', body: 'Subtitle 5')
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        appBarTheme: AppBarTheme(color: Color(0xFFFEF7FF)),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Bildirimler"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Expanded(
                  child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return buildNotificationItem(context, notification);
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/notification_model.dart';
import '../screens/form_response_detail_screen.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;

  const NotificationItem({required this.notification, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ListTile(
        leading: Icon(Icons.account_circle, size: 50, color: Colors.black),
        title: Text(notification.title),
        subtitle: Text(notification.body),
        trailing: IconButton(
          icon: Icon(Icons.arrow_circle_right, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FormResponseDetailScreen(
                  responseId: notification.responseId,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

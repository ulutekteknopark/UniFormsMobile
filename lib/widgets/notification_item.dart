import 'package:deneme2/models/notification_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildNotificationItem(
    BuildContext context, NotificationModel notification) {
  return Card(
    color: Colors.white,
    child: ListTile(
      //leading: Image.asset('assets/icons/ic_list-item.png'),
      leading: Icon(Icons.account_circle, size: 50, color: Colors.black),
      title: Text(notification.title),
      subtitle: Text(notification.body),
      trailing: IconButton(
        icon: Icon(Icons.arrow_circle_right, color: Colors.black),
        onPressed: () {},
      ),
    ),
  );
}

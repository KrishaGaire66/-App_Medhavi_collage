import 'package:flutter/material.dart';

AppBar buildDownloadAppBar(BuildContext context) {
  return AppBar(
    title: Text('Question Papers', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
    backgroundColor: Colors.indigo[600],
    elevation: 0,
    actions: [
      IconButton(
        icon: Icon(Icons.refresh),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Refreshing question papers...')));
        },
      ),
    ],
  );
}

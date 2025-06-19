import 'package:flutter/material.dart';

void showSortBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (_) => Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Sort by', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          ListTile(leading: Icon(Icons.date_range), title: Text('Upload Date'), onTap: () => Navigator.pop(context)),
          ListTile(leading: Icon(Icons.sort_by_alpha), title: Text('Title'), onTap: () => Navigator.pop(context)),
          ListTile(leading: Icon(Icons.folder), title: Text('Subject'), onTap: () => Navigator.pop(context)),
          ListTile(leading: Icon(Icons.calendar_today), title: Text('Year'), onTap: () => Navigator.pop(context)),
        ],
      ),
    ),
  );
}

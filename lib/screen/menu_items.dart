import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subtitle;
  final IconData icon;

  MenuItem({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

final List<MenuItem> menuItems = [
  MenuItem(title: 'Assignments', subtitle: 'View & Submit Assignments', icon: Icons.assignment),
  MenuItem(title: 'Attendance', subtitle: 'Monthly & aggregate Reports', icon: Icons.bar_chart),
  MenuItem(title: 'Homework', subtitle: 'Daily Homeworks', icon: Icons.book),
  MenuItem(title: 'Reading Materials', subtitle: 'View Notes & Resources', icon: Icons.menu_book),
  MenuItem(title: 'Library', subtitle: 'Issued & Returned Books', icon: Icons.library_books),
  MenuItem(title: 'Downloads', subtitle: 'Study Materials & Files', icon: Icons.download),
  MenuItem(title: 'Leave Note', subtitle: 'Send Absent Note', icon: Icons.note_alt),
];

import 'package:flutter/material.dart';

class ResultCountRow extends StatelessWidget {
  final int count;
  final VoidCallback onSortTap;

  const ResultCountRow({super.key, required this.count, required this.onSortTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$count question papers found', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
          TextButton.icon(onPressed: onSortTap, icon: Icon(Icons.sort, size: 18), label: Text('Sort')),
        ],
      ),
    );
  }
}

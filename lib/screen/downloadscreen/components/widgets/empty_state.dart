import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
          SizedBox(height: 16),
          Text('No question papers found', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          SizedBox(height: 8),
          Text('Try adjusting your search or filters', style: TextStyle(color: Colors.grey[500])),
        ],
      ),
    );
  }
}

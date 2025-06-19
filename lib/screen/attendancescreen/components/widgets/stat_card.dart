import 'package:flutter/material.dart';

class StatCards extends StatelessWidget {
  const StatCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildStat('Present', '85%', '17 days', Colors.green, Icons.check_circle)),
        const SizedBox(width: 12),
        Expanded(child: _buildStat('Absent', '10%', '2 days', Colors.red, Icons.cancel)),
        const SizedBox(width: 12),
        Expanded(child: _buildStat('Late', '5%', '1 day', Colors.orange, Icons.access_time)),
      ],
    );
  }

  Widget _buildStat(String title, String value, String count, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 18)),
          Text(count, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
          Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ],
      ),
    );
  }
}

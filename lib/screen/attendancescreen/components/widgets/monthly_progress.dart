import 'package:flutter/material.dart';
import 'package:medhavi/utils/colors.dart';

class MonthlyProgress extends StatelessWidget {
  const MonthlyProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor.withOpacity(0.1), primaryColor.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: primaryColor.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.calendar_month, color: primaryColor),
              const SizedBox(width: 8),
              const Text('January 2025 Overview', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _ProgressItem(label: 'Total Classes', value: '20'),
              _ProgressItem(label: 'Attended', value: '17'),
              _ProgressItem(label: 'Missed', value: '3'),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Overall Attendance Rate', style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: 0.85,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            minHeight: 8,
          ),
          const SizedBox(height: 8),
          Text(
            '85% - Excellent Attendance!',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: primaryColor),
          ),
        ],
      ),
    );
  }
}

class _ProgressItem extends StatelessWidget {
  final String label;
  final String value;

  const _ProgressItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor)),
        Text(label, style: TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    );
  }
}

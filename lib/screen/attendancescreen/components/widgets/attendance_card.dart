import 'package:flutter/material.dart';
import 'package:medhavi/models/attendance_model.dart';

class AttendanceCard extends StatelessWidget {
  final AttendanceRecord record;

  const AttendanceCard({super.key, required this.record});

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'present':
        return Colors.green;
      case 'absent':
        return Colors.red;
      case 'late':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String? status) {
    switch (status?.toLowerCase()) {
      case 'present':
        return Icons.check_circle;
      case 'absent':
        return Icons.cancel;
      case 'late':
        return Icons.access_time;
      default:
        return Icons.help;
    }
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return '';
    try {
      final date = DateTime.parse(dateStr);
      return "${date.day}/${date.month}/${date.year}";
    } catch (_) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Status icon
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: _getStatusColor(record.status).withOpacity(0.2),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(_getStatusIcon(record.status), color: _getStatusColor(record.status)),
            ),
            const SizedBox(width: 16),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(record.subject ?? 'Unknown Subject', style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(record.teacher ?? 'Unknown Teacher', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 14, color: Colors.grey[500]),
                      const SizedBox(width: 4),
                      Text(_formatDate(record.date), style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                      const SizedBox(width: 16),
                      Icon(Icons.access_time, size: 14, color: Colors.grey[500]),
                      const SizedBox(width: 4),
                      Text(record.time ?? '', style: TextStyle(color: Colors.grey[600], fontSize: 10)),
                    ],
                  )
                ],
              ),
            ),

            // Status badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getStatusColor(record.status).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _getStatusColor(record.status).withOpacity(0.3)),
              ),
              child: Text(
                (record.status ?? '').toUpperCase(),
                style: TextStyle(
                  color: _getStatusColor(record.status),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

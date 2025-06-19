import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medhavi/models/leave_model.dart';

class LeaveCard extends StatelessWidget {
  final LeaveRequest leave;

  const LeaveCard({super.key, required this.leave});

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('yyyy-MM-dd');

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text("${leave.type} Leave"),
        subtitle: Text(
          "${dateFormatter.format(leave.fromDate)} - ${dateFormatter.format(leave.toDate)}\nReason: ${leave.reason}",
        ),
        isThreeLine: true,
        leading: const Icon(Icons.calendar_today),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ApplyLeaveDialog extends StatefulWidget {
  const ApplyLeaveDialog({super.key});

  @override
  State<ApplyLeaveDialog> createState() => _ApplyLeaveDialogState();
}

class _ApplyLeaveDialogState extends State<ApplyLeaveDialog> {
  final TextEditingController reasonController = TextEditingController();
  DateTime? fromDate;
  DateTime? toDate;
  String? leaveType;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Apply Leave"),
      content: SizedBox(
        height: 320, // You can adjust this height
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: leaveType,
                hint: const Text("Select Leave Type"),
                items:
                    ["Casual", "Sick", "Paid", "Unpaid"]
                        .map(
                          (type) =>
                              DropdownMenuItem(value: type, child: Text(type)),
                        )
                        .toList(),
                onChanged: (value) => setState(() => leaveType = value),
              ),
              const SizedBox(height: 8),
              TextFormField(
                readOnly: true,
                decoration: const InputDecoration(labelText: "From Date"),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2023),
                    lastDate: DateTime(2026),
                  );
                  if (picked != null) setState(() => fromDate = picked);
                },
                controller: TextEditingController(
                  text:
                      fromDate != null
                          ? DateFormat('yyyy-MM-dd').format(fromDate!)
                          : '',
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                readOnly: true,
                decoration: const InputDecoration(labelText: "To Date"),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: fromDate ?? DateTime.now(),
                    firstDate: fromDate ?? DateTime.now(),
                    lastDate: DateTime(2026),
                  );
                  if (picked != null) setState(() => toDate = picked);
                },
                controller: TextEditingController(
                  text:
                      toDate != null
                          ? DateFormat('yyyy-MM-dd').format(toDate!)
                          : '',
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: reasonController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: "Reason"),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          onPressed: () {
            if (leaveType != null &&
                fromDate != null &&
                toDate != null &&
                reasonController.text.isNotEmpty) {
              final newLeave = {
                "id": DateTime.now().millisecondsSinceEpoch.toString(),
                "type": leaveType!,
                "fromDate": DateFormat('yyyy-MM-dd').format(fromDate!),
                "toDate": DateFormat('yyyy-MM-dd').format(toDate!),
                "reason": reasonController.text,
              };
              Navigator.pop(context);
            }
          },
          child: const Text("Apply"),
        ),
      ],
    );
  }
}

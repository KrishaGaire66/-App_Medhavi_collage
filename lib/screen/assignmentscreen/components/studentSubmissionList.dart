import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Studentsubmissionlist extends ConsumerStatefulWidget {
  const Studentsubmissionlist({super.key});

  @override
  ConsumerState<Studentsubmissionlist> createState() =>
      _StudentsubmissionlistState();
}

class _StudentsubmissionlistState extends ConsumerState<Studentsubmissionlist> {
  // Dummy data (replace this with real provider/state logic)
  final List<Map<String, String>> studentSubmissions = [
    {
      'fileName': 'Math Assignment.pdf',
      'submittedOn': '2025-06-05',
      'description': 'Algebra homework',
      'filePath': 'path/to/math_assignment.pdf',
    },
    {
      'fileName': 'Science Report.docx',
      'submittedOn': '2025-06-04',
      'description': 'Plant cell analysis',
      'filePath': 'path/to/science_report.docx',
    },
  ];

  void openFile(String filePath) {
    // Placeholder for opening file logic
    debugPrint("Opening file: $filePath");
  }

  Widget studentSubmissionList() {
    if (studentSubmissions.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(thickness: 1.5),
        const Text(
          "Your Submitted Assignments",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        ...studentSubmissions.map(
          (submission) => Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              title: Text(submission['fileName']!),
              subtitle: Text(
                "Submitted on: ${submission['submittedOn']}\n${submission['description']}",
              ),
              trailing: IconButton(
                icon: const Icon(Icons.remove_red_eye),
                onPressed: () => openFile(submission['filePath']!),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: studentSubmissionList(),
    );
  }
}

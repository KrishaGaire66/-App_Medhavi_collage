import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';  // Add intl package in pubspec.yaml

class Studentuploadsection extends ConsumerStatefulWidget {
  const Studentuploadsection({super.key});

  @override
  ConsumerState<Studentuploadsection> createState() => _StudentuploadsectionState();
}

class _StudentuploadsectionState extends ConsumerState<Studentuploadsection> {
  String submissionDescription = '';
  dynamic selectedFile;
  DateTime? submissionDate;

  void pickFile() {
    // TODO: Implement file picker logic here
    print("File picker triggered");
    // Example:
    // selectedFile = await FilePicker.platform.pickFiles();
    setState(() {
      // For demonstration, just assign a dummy file object with path
      selectedFile = DummyFile('/path/to/selected/file.txt');
      submissionDate = DateTime.now();
    });
  }

  void uploadAssignment() {
    // TODO: Implement upload logic here
    print("Uploading assignment: $submissionDescription, file: ${selectedFile?.path}");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Upload your completed assignment:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        TextField(
          decoration: const InputDecoration(
            labelText: "Add Description",
            border: OutlineInputBorder(),
          ),
          onChanged: (val) => setState(() {
            submissionDescription = val;
          }),
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: pickFile,
          icon: const Icon(Icons.upload),
          label: const Text("Select Assignment File"),
        ),
        if (selectedFile != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text("Selected File: ${selectedFile!.path.split('/').last}"),
          ),
        if (submissionDate != null)
          Text(
            "Submission Date: ${DateFormat.yMMMd().format(submissionDate!)}",
            style: const TextStyle(color: Colors.grey),
          ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: uploadAssignment,
          child: const Text("Submit Assignment"),
        ),
      ],
    );
  }
}

// Dummy class to simulate a file picked; replace with actual File or PlatformFile from your picker
class DummyFile {
  final String path;
  DummyFile(this.path);
}

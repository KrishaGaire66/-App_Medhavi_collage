import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medhavi/models/assignment_model.dart';
// import your other dependencies or providers here

// Dummy enums and variables (replace with your actual ones)
enum UserRole { teacher, student }
UserRole selectedRole = UserRole.teacher; // example static role

class Buildassignmentcard extends ConsumerStatefulWidget {
  final Assignment assignment;

  const Buildassignmentcard({Key? key, required this.assignment}) : super(key: key);

  @override
  ConsumerState<Buildassignmentcard> createState() => _BuildassignmentcardState();
}

class _BuildassignmentcardState extends ConsumerState<Buildassignmentcard> {
  // Example method to open a file (replace with actual implementation)
  void openFile(String fileUrl) {
    // TODO: implement file opening logic here
    print("Opening file: $fileUrl");
  }

  @override
  Widget build(BuildContext context) {
    final assignment = widget.assignment;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    assignment.title ?? "",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (selectedRole == UserRole.teacher)
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("Delete Assignment"),
                        content: const Text(
                          "Are you sure you want to delete this assignment?",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              // TODO: Implement deletion logic here,
                              // maybe call a Riverpod notifier or callback passed as param

                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Delete",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 6),
            Text(assignment.description ?? ""),
            const SizedBox(height: 8),
            Text(
              "Uploaded on: ${assignment.uploadDate ?? ""}",
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 10),

            // Replace EnhancedDownloadButton with a simple button for demo:
            ElevatedButton.icon(
              onPressed: () => openFile(assignment.fileUrl ?? ""),
              icon: const Icon(Icons.download),
              label: Text("Download ${assignment.fileName ?? ""}"),
            ),
          ],
        ),
      ),
    );
  }
}

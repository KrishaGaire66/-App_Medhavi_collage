import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:medhavi/hive/hive_key.dart';
import 'package:medhavi/hive/hive_service.dart';
import 'package:medhavi/models/assignment_model.dart';
import 'package:medhavi/provider/assignment_provider.dart';
import 'package:medhavi/service/assignment_service.dart';
import 'package:medhavi/utils/colors.dart';
import 'package:medhavi/widgets/custom_download.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';

enum UserRole { teacher, student }

class AssignmentScreen extends ConsumerStatefulWidget {
  const AssignmentScreen({super.key});

  @override
  ConsumerState<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends ConsumerState<AssignmentScreen> {
  //

  late String userName;

  @override
  void initState() {
    super.initState();
    var authBox = Hive.box('authBox');
    userName = authBox.get('name') ?? 'User';
  }

  UserRole selectedRole = UserRole.student;

  List<Map<String, dynamic>> studentSubmissions = [];

  File? selectedFile;
  String? submissionDescription;
  DateTime? submissionDate;

  String? teacherAssignmentTitle;
  String? teacherAssignmentDescription;

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
        submissionDate = DateTime.now();
      });
    }
  }

  void uploadAssignment() {
    if (selectedFile != null && submissionDescription != null) {
      final fileName = selectedFile!.path.split('/').last;
      final newSubmission = {
        'fileName': fileName,
        'description': submissionDescription!,
        'submittedOn': DateFormat('yyyy-MM-dd').format(DateTime.now()),
        'filePath': selectedFile!.path,
      };

      setState(() {
        studentSubmissions.insert(0, newSubmission);
        selectedFile = null;
        submissionDescription = null;
        submissionDate = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Assignment submitted successfully!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a file and add a description"),
        ),
      );
    }
  }

  void openFile(String path) {
    OpenFile.open(path);
  }

  Widget buildAssignmentCard(Assignment assignment) {
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
                    onPressed:
                        () => showDialog(
                          context: context,
                          builder:
                              (_) => AlertDialog(
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
                                      setState(() {
                                        // assignments.remove(assignment);
                                      });
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
            EnhancedDownloadButton(
              onPressed: () => openFile(assignment.fileUrl ?? ""),
              fileName: assignment.fileName ?? "",
            ),
            // ElevatedButton.icon(
            //   onPressed: () => openFile(assignment.fileUrl ?? ""),
            //   icon: const Icon(Icons.download),
            //   label: Text("Download ${assignment.fileName ?? ""}"),
            // ),
          ],
        ),
      ),
    );
  }

  Widget teacherUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Upload New Assignment",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 10),
        TextField(
          decoration: const InputDecoration(
            labelText: "Assignment Title",
            border: OutlineInputBorder(),
          ),
          onChanged: (val) => teacherAssignmentTitle = val,
        ),
        const SizedBox(height: 10),
        TextField(
          decoration: const InputDecoration(
            labelText: "Assignment Description",
            border: OutlineInputBorder(),
          ),
          onChanged: (val) => teacherAssignmentDescription = val,
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: pickFile,
          icon: const Icon(Icons.upload_file),
          label: const Text("Select File (Image/PDF)"),
        ),
        if (selectedFile != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text("Selected File: ${selectedFile!.path.split('/').last}"),
          ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            if (selectedFile != null &&
                teacherAssignmentTitle != null &&
                teacherAssignmentDescription != null) {
              final fileName = selectedFile!.path.split('/').last;
              final newAssignment = {
                'title': teacherAssignmentTitle!,
                'description': teacherAssignmentDescription!,
                'fileUrl': selectedFile!.path, // local path
                'fileName': fileName,
                'uploadDate': DateFormat('yyyy-MM-dd').format(DateTime.now()),
              };

              setState(() {
                //  assignments.insert(0, newAssignment);
                selectedFile = null;
                teacherAssignmentTitle = null;
                teacherAssignmentDescription = null;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Assignment uploaded successfully!'),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please fill all fields and select a file'),
                ),
              );
            }
          },
          child: const Text("Submit Assignment"),
        ),
      ],
    );
  }

  Widget studentUploadSection() {
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
          onChanged: (val) => submissionDescription = val,
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
              title: Text(submission['fileName']),
              subtitle: Text(
                "Submitted on: ${submission['submittedOn']}\n${submission['description']}",
              ),
              trailing: IconButton(
                icon: const Icon(Icons.remove_red_eye),
                onPressed: () => openFile(submission['filePath']),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isStudent = selectedRole == UserRole.student;
    final assignmentsAsync = ref.watch(assignmentProvider);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: linearGradient1),
          ),
          title: Text('$userName Assignments'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          //   actions: [
          //     PopupMenuButton<UserRole>(
          //       onSelected: (role) => setState(() => selectedRole = role),
          //       itemBuilder:
          //           (context) => [
          //             const PopupMenuItem(
          //               value: UserRole.student,
          //               child: Text("Student Mode"),
          //             ),
          //             const PopupMenuItem(
          //               value: UserRole.teacher,
          //               child: Text("Teacher Mode"),
          //             ),
          //           ],
          //       icon: const Icon(Icons.switch_account),
          //     ),
          //   ],
          // ),
        ),
      ),
      body: assignmentsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (assignmentResponse) {
          final assignments =
              assignmentResponse.data; // List<Map<String, dynamic>>

          return SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                isStudent ? studentUploadSection() : teacherUploadSection(),
                const SizedBox(height: 20),
                const Divider(thickness: 1.5),
                const Text(
                  "Assignment List",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ...assignments!.map(buildAssignmentCard).toList(),
                if (isStudent) studentSubmissionList(),
              ],
            ),
          );
        },
      ),
    );
  }
}

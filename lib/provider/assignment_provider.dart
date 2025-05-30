import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medhavi/models/assignment_model.dart';
import 'package:medhavi/service/assignment_service.dart';
import 'package:dio/dio.dart';

// 1. Provide a singleton Dio instance
final dioProvider = Provider<Dio>((ref) => Dio());

// 2. Provide the AssignmentService
final assignmentServiceProvider = Provider<AssignmentService>(
  (ref) => AssignmentService(ref.read(dioProvider)),
);

// 3. Provide FutureProvider to fetch assignment
final assignmentProvider = FutureProvider<AssignmentResponse>((ref) async {
  final service = ref.read(assignmentServiceProvider);
  return service.fetchAssignments();
});

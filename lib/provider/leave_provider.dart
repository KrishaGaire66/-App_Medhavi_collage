import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:medhavi/models/leave_model.dart';
import 'package:medhavi/service/leave_service.dart';

// 1. Provide a singleton Dio instance
final dioProvider = Provider<Dio>((ref) => Dio());

// 2. Provide the AssignmentService
final leaveServiceProvider = Provider<LeaveService>(
  (ref) => LeaveService(ref.read(dioProvider)),
);

// 3. Provide FutureProvider to fetch assignment
final leaveProvider = FutureProvider<LeaveResponse>((ref) async {
  final service = ref.read(leaveServiceProvider);
  return service.fetchLeave();
});

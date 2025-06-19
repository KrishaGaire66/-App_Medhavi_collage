import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:medhavi/models/attendance_model.dart';
import 'package:medhavi/service/attendance_service.dart';

// 1. Provide a singleton Dio instance
final dioProvider = Provider<Dio>((ref) => Dio());

// 2. Provide the AssignmentService
final attendanceServiceProvider = Provider<AttendanceService>(
  (ref) => AttendanceService(ref.read(dioProvider)),
);

// 3. Provide FutureProvider to fetch assignment
final attendanceProvider = FutureProvider<AttendanceResponse>((ref) async {
  final service = ref.read(attendanceServiceProvider);
  return service.fetchAttendance();
});

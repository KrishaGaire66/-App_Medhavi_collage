import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medhavi/models/assignment_model.dart';
import 'package:dio/dio.dart';
import 'package:medhavi/models/calender_model.dart';
import 'package:medhavi/service/calender_service.dart';

// 1. Provide a singleton Dio instance
final dioProvider = Provider<Dio>((ref) => Dio());

// 2. Provide the AssignmentService
final calenderServiceProvider = Provider<CalenderService>(
  (ref) => CalenderService(ref.read(dioProvider)),
);

// 3. Provide FutureProvider to fetch assignment
final calenderProvider = FutureProvider<CalanderResponse>((ref) async {
  final service = ref.read(calenderServiceProvider);
  return service.fetchEvents();
});

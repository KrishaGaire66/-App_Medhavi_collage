import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medhavi/models/assignment_model.dart';
import 'package:dio/dio.dart';
import 'package:medhavi/models/calender_model.dart';
import 'package:medhavi/models/download_model.dart';
import 'package:medhavi/service/calender_service.dart';
import 'package:medhavi/service/download_service.dart';

// 1. Provide a singleton Dio instance
final dioProvider = Provider<Dio>((ref) => Dio());

// 2. Provide the AssignmentService
final downloadPaperServiceProvider = Provider<DownloadService>(
  (ref) => DownloadService(ref.read(dioProvider)),
);

// 3. Provide FutureProvider to fetch assignment
final downloadPaperProvider = FutureProvider<DownloadPaperResponse>((ref) async {
  final service = ref.read(downloadPaperServiceProvider);
  return service.fetchDownloadPaper();
});

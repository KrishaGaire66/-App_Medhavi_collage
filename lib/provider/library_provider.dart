import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:medhavi/models/library_model.dart';
import 'package:medhavi/service/library_service.dart';

// 1. Provide a singleton Dio instance
final dioProvider = Provider<Dio>((ref) => Dio());

// 2. Provide the LibraryService
final libraryServiceProvider = Provider<LibraryService>(
  (ref) => LibraryService(ref.read(dioProvider)),
);

// 3. Provide FutureProvider to fetch 
final libraryProvider = FutureProvider<BookResponse>((ref) async {
  final service = ref.read(libraryServiceProvider);
  return service.fetchLibrary();
});

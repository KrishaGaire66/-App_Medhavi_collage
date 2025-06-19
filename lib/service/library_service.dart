import 'package:dio/dio.dart';
import 'package:medhavi/json.dart';
import 'package:medhavi/api.dart';
import 'package:medhavi/models/attendance_model.dart';
import 'package:medhavi/models/leave_model.dart';
import 'package:medhavi/models/library_model.dart';

class LibraryService {
  final Dio dio;

  LibraryService(this.dio);
  Future<BookResponse> fetchLibrary() async {
    final response = JsonData.booksJson;

    BookResponse bookResponse = BookResponse.fromJson(
      response,
    );

    // // assuming at least one assignment exists
    // Assignment assignment = assignmentResponse.data!.first;

//print(attendanceResponse.data!.first.subject); // now should print correctly
    return BookResponse();
  }

 
}

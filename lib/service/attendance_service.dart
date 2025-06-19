import 'package:dio/dio.dart';
import 'package:medhavi/json.dart';
import 'package:medhavi/api.dart';
import 'package:medhavi/models/attendance_model.dart';

class AttendanceService {
  final Dio dio;

  AttendanceService(this.dio);
  Future<AttendanceResponse> fetchAttendance() async {
    final response = JsonData.attendanceJson;

    AttendanceResponse attendanceResponse = AttendanceResponse.fromJson(
      response,
    );

    // // assuming at least one assignment exists
    // Assignment assignment = assignmentResponse.data!.first;

//print(attendanceResponse.data!.first.subject); // now should print correctly
    return attendanceResponse;
  }

 
}

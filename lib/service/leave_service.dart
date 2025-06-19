import 'package:dio/dio.dart';
import 'package:medhavi/json.dart';
import 'package:medhavi/api.dart';
import 'package:medhavi/models/attendance_model.dart';
import 'package:medhavi/models/leave_model.dart';

class LeaveService {
  final Dio dio;

  LeaveService(this.dio);
  Future<LeaveResponse> fetchLeave() async {
    final response = JsonData.leaveRequestJson;

    LeaveResponse leaveResponse = LeaveResponse.fromJson(
      response,
    );

    // // assuming at least one assignment exists
    // Assignment assignment = assignmentResponse.data!.first;

//print(attendanceResponse.data!.first.subject); // now should print correctly
    return leaveResponse;
  }

 
}

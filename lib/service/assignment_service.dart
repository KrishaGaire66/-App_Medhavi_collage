import 'package:dio/dio.dart';
import 'package:medhavi/api.dart';
import 'package:medhavi/json.dart';
import 'package:medhavi/models/assignment_model.dart';

class AssignmentService {
  final Dio dio;

  AssignmentService(this.dio);
  Future<AssignmentResponse> fetchAssignments() async {
    final response =  JsonData.assignmentJson;

    AssignmentResponse assignmentResponse = AssignmentResponse.fromJson(
      response,
    );

    // // assuming at least one assignment exists
    // Assignment assignment = assignmentResponse.data!.first;

    // print(assignment.fileName); // now should print correctly
    return assignmentResponse;
  }

  fetchEvents() {}
}

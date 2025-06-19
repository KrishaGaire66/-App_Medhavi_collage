import 'package:dio/dio.dart';
import 'package:medhavi/api.dart';
import 'package:medhavi/json.dart';
import 'package:medhavi/models/calender_model.dart';

class CalenderService {
  final Dio dio;

  CalenderService(this.dio);
  Future<CalanderResponse> fetchEvents() async {
    final response =  JsonData.assignmentJson;

    CalanderResponse calanderResponse = CalanderResponse.fromJson(
      response,
    );

    // // assuming at least one assignment exists
    // Assignment assignment = assignmentResponse.data!.first;

    // print(assignment.fileName); // now should print correctly
    return calanderResponse;
  }
}

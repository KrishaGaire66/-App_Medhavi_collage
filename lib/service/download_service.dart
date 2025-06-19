import 'package:dio/dio.dart';
import 'package:medhavi/json.dart';
import 'package:medhavi/models/download_model.dart';

class DownloadService {
  final Dio dio;

  DownloadService(this.dio);
  Future<DownloadPaperResponse> fetchDownloadPaper() async {
    final response = JsonData.downloadJson;

    DownloadPaperResponse downloadPaperResponse = DownloadPaperResponse.fromJson(
      response,
    );

    // // assuming at least one assignment exists
    // Assignment assignment = assignmentResponse.data!.first;

//print(attendanceResponse.data!.first.subject); // now should print correctly
    return downloadPaperResponse;
  }

 
}

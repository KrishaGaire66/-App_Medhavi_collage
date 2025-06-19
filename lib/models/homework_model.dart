class HomeworkModel {
  final String date;
  final String status;
  final String subject;
  final String time;
  final String teacher;

  HomeworkModel({
    required this.date,
    required this.status,
    required this.subject,
    required this.time,
    required this.teacher,
  });

  factory HomeworkModel.fromJson(Map<String, dynamic> json) {
    return HomeworkModel(
      date: json['date'],
      status: json['status'],
      subject: json['subject'],
      time: json['time'],
      teacher: json['teacher'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'status': status,
      'subject': subject,
      'time': time,
      'teacher': teacher,
    };
  }
}
class HomeworkResponse {
  final bool? status;
  final String? message;
  final List<HomeworkModel>? data;

  HomeworkResponse({
    this.status,
    this.message,
    this.data,
  });

  factory HomeworkResponse.fromJson(Map<String, dynamic> json) {
    return HomeworkResponse(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List?)
              ?.map((e) => HomeworkModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.map((e) => e.toJson()).toList(),
      };
}

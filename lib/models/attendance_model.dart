class AttendanceRecord {
  final String? date;
  final String? status;
  final String? subject;
  final String? time;
  final String? teacher;

  AttendanceRecord({
    this.date,
    this.status,
    this.subject,
    this.time,
    this.teacher,
  });

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    return AttendanceRecord(
      date: json['date'],
      status: json['status'],
      subject: json['subject'],
      time: json['time'],
      teacher: json['teacher'],
    );
  }

  Map<String, dynamic> toJson() => {
        "date": date,
        "status": status,
        "subject": subject,
        "time": time,
        "teacher": teacher,
      };
}
class AttendanceResponse {
  final bool? status;
  final String? message;
  final List<AttendanceRecord>? data;

  AttendanceResponse({
    this.status,
    this.message,
    this.data,
  });
  

  factory AttendanceResponse.fromJson(Map<String, dynamic> json) {
    return AttendanceResponse(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List?)
              ?.map((e) => AttendanceRecord.fromJson(e))
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

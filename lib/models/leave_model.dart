class LeaveType {
  static const List<String> types = ['Casual', 'Sick', 'Paid', 'Unpaid'];
}

class LeaveRequest {
  final String id;
  final String type;
  final DateTime fromDate;
  final DateTime toDate;
  final String reason;

  LeaveRequest({
    required this.id,
    required this.type,
    required this.fromDate,
    required this.toDate,
    required this.reason,
  });

  // Factory constructor to create LeaveRequest from JSON
  factory LeaveRequest.fromJson(Map<String, dynamic> json) {
    return LeaveRequest(
      id: json['id'],
      type: json['type'],
      fromDate: DateTime.parse(json['fromDate']), // Proper DateTime parsing
      toDate: DateTime.parse(json['toDate']),
      reason: json['reason'],
    );
  }

  // Convert LeaveRequest to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'fromDate': fromDate.toIso8601String(), // Convert DateTime to String
      'toDate': toDate.toIso8601String(),
      'reason': reason,
    };
  }
}

class LeaveResponse {
  final bool? status;
  final String? message;
  final List<LeaveRequest>? data;

  LeaveResponse({
    this.status,
    this.message,
    this.data,
  });

  factory LeaveResponse.fromJson(Map<String, dynamic> json) {
    return LeaveResponse(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List?)
              ?.map((e) => LeaveRequest.fromJson(e))
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

class SubmittedLeave {
  final int? studentId;
  final String? leaveId;
  final String? submittedDate;
  final String? status;

  SubmittedLeave({
    this.studentId,
    this.leaveId,
    this.submittedDate,
    this.status,
  });

  factory SubmittedLeave.fromJson(Map<String, dynamic> json) {
    return SubmittedLeave(
      studentId: json['studentId'],
      leaveId: json['leaveId'],
      submittedDate: json['submittedDate'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
        "studentId": studentId,
        "leaveId": leaveId,
        "submittedDate": submittedDate,
        "status": status,
      };
}

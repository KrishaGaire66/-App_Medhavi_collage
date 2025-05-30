class Assignment {
  final int? id;
  final String? title;
  final String? description;
  final String? fileUrl;
  final String? fileName;
  final String? uploadDate;
  final String? deadline;

  Assignment({
    this.id,
    this.title,
    this.description,
    this.fileUrl,
    this.fileName,
    this.uploadDate,
    this.deadline,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      fileUrl: json['fileUrl'],
      fileName: json['fileName'],
      uploadDate: json['uploadDate'],
      deadline: json['deadline'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "fileUrl": fileUrl,
        "fileName": fileName,
        "uploadDate": uploadDate,
        "deadline": deadline,
      };
}

class AssignmentResponse {
  final bool? status;
  final String? message;
  final List<Assignment>? data;

  AssignmentResponse({
    this.status,
    this.message,
    this.data,
  });

  factory AssignmentResponse.fromJson(Map<String, dynamic> json) {
    return AssignmentResponse(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List?)
              ?.map((e) => Assignment.fromJson(e))
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

class SubmittedAssignment {
  final int? studentId;
  final int? assignmentId;
  final String? submittedFileUrl;
  final String? submittedFileName;
  final String? submittedDate;

  SubmittedAssignment({
    this.studentId,
    this.assignmentId,
    this.submittedFileUrl,
    this.submittedFileName,
    this.submittedDate,
  });

  factory SubmittedAssignment.fromJson(Map<String, dynamic> json) {
    return SubmittedAssignment(
      studentId: json['studentId'],
      assignmentId: json['assignmentId'],
      submittedFileUrl: json['submittedFileUrl'],
      submittedFileName: json['submittedFileName'],
      submittedDate: json['submittedDate'],
    );
  }

  Map<String, dynamic> toJson() => {
        "studentId": studentId,
        "assignmentId": assignmentId,
        "submittedFileUrl": submittedFileUrl,
        "submittedFileName": submittedFileName,
        "submittedDate": submittedDate,
      };
}

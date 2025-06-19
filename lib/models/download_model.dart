class DownloadPaper {
  final String id;
  final String title;
  final String subject;
  final String year;
  final String semester;
  final String fileSize;
  final String uploadDate;
  final bool isDownloaded;

  DownloadPaper({
    required this.id,
    required this.title,
    required this.subject,
    required this.year,
    required this.semester,
    required this.fileSize,
    required this.uploadDate,
    required this.isDownloaded,
  });

  factory DownloadPaper.fromJson(Map<String, dynamic> json) {
    return DownloadPaper(
      id: json['id'],
      title: json['title'],
      subject: json['subject'],
      year: json['year'],
      semester: json['semester'],
      fileSize: json['fileSize'],
      uploadDate: json['uploadDate'],
      isDownloaded: json['isDownloaded'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subject': subject,
      'year': year,
      'semester': semester,
      'fileSize': fileSize,
      'uploadDate': uploadDate,
      'isDownloaded': isDownloaded,
    };
  }
}

class DownloadPaperResponse {
  final bool status;
  final String message;
  final List<DownloadPaper> data;

  DownloadPaperResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DownloadPaperResponse.fromJson(Map<String, dynamic> json) {
    return DownloadPaperResponse(
      status: json['status'],
      message: json['message'],
      data: List<DownloadPaper>.from(
        json['data'].map((item) => DownloadPaper.fromJson(item)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class Calender {
  final String? title;
  final String? description;
  final String? eventDate;

  Calender({
    this.title,
    this.description,
    this.eventDate,
  });

  factory Calender.fromJson(Map<String, dynamic> json) {
    return Calender(
     
      title: json['title'],
      description: json['description'],
      eventDate: json['eventDate'],

    );
  }

  Map<String, dynamic> toJson() => {
       
        "title": title,
        "description": description,
        "eventDate": eventDate,
      };
}

class CalanderResponse {
  final bool? status;
  final String? message;
  final List<Calender>? data;

  CalanderResponse({
    this.status,
    this.message,
    this.data,
  });

  factory CalanderResponse.fromJson(Map<String, dynamic> json) {
    return CalanderResponse(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List?)
              ?.map((e) => Calender.fromJson(e))
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


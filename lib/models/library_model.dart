class Book {
  final String? title;
  final String? author;
  final bool? available;

  Book({
    this.title,
    this.author,
    this.available,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'],
      author: json['author'],
      available: json['available'],
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "author": author,
        "available": available,
      };
}

class BookResponse {
  final bool? status;
  final String? message;
  final List<Book>? data;

  BookResponse({
    this.status,
    this.message,
    this.data,
  });

  factory BookResponse.fromJson(Map<String, dynamic> json) {
    return BookResponse(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List?)
              ?.map((e) => Book.fromJson(e))
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

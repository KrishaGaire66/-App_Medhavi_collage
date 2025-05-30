class JsonData {
  JsonData._();
  static Map<String, dynamic> assignmentJson = {
    "status": true,
    "message": "Assignments fetched successfully",
    "data": [
      {
        "id": 1,
        "title": "Math Assignment 1",
        "description": "Solve the problems from chapter 2.",
        "fileUrl": "https://example.com/sample.pdf",
        "fileName": "math_assignment1.pdf",
        "uploadDate": "2025-02-25",
        "deadline": "2025-06-01",
      },
      {
        "id": 2,
        "title": "Economy Assignment",
        "description": "Explain Budget with numericals.",
        "fileUrl": "https://example.com/sample.jpg",
        "fileName": "Economy_assignment.jpg",
        "uploadDate": "2025-03-24",
        "deadline": "2025-05-31",
      },
      {
        "id": 3,
        "title": "Account Assignment",
        "description": "Explain Accounting with diagrams.",
        "fileUrl": "https://example.com/error.jpg",
        "fileName": "Account_assignment.jpg",
        "uploadDate": "2025-05-24",
        "deadline": "2025-05-31",
      },
    ],
  };

  Map<String, dynamic> submitAssignment = {
    "studentId": 101,
    "assignmentId": 1,
    "submittedFileUrl": "https://example.com/submitted_math_assignment1.pdf",
    "submittedFileName": "submitted_math_assignment1.pdf",
    "submittedDate": "2025-05-24",
  };
}

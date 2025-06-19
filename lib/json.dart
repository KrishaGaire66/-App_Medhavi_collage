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
static Map<String, dynamic> calenderJson = {
  "status": true,
  "message": "Sample titles fetched successfully",
  "data": [
    {
      "event": "Parents Meeting",
      "description": "Parents meeting with teacher",
      "eventDate": "2025-02-25",
    },
    {
      "event": "Science Fair",
      "description": "Annual school science exhibition",
      "eventDate": "2025-03-10",
    },
    {
      "event": "Sports Day",
      "description": "Inter-school sports competition",
      "eventDate": "2025-04-05",
    },
    {
      "event": "Cultural Program",
      "description": "Dance and music performances by students",
      "eventDate": "2025-05-15",
    },
    {
      "event": "Final Exams Start",
      "description": "Final term examinations begin",
      "eventDate": "2025-06-01",
    },
    {
      "event": "Art Exhibition",
      "description": "Display of student artworks",
      "eventDate": "2025-07-20",
    },
    {
      "event": "Independence Day Celebration",
      "description": "Flag hoisting and performances",
      "eventDate": "2025-08-15",
    },
    {
      "event": "Teacher's Day",
      "description": "Celebrating Teacher's Day",
      "eventDate": "2025-09-05",
    },
  ],
};

  static Map<String, dynamic> attendanceJson = {
  "status": true,
  "message": "Attendance records fetched successfully",
  "data": [
    
  {
    "date": "2025-01-15",
    "status": "present",
    "subject": "Mathematics",
    "time": "09:00 AM",
    "teacher": "Dr. Smith"
  },
  {
    "date": "2025-01-15",
    "status": "present",
    "subject": "Physics",
    "time": "10:30 AM",
    "teacher": "Prof. Johnson"
  },
  {
    "date": "2025-01-15",
    "status": "present",
    "subject": "English",
    "time": "01:00 PM",
    "teacher": "Ms. Brown"
  },
  {
    "date": "2025-01-14",
    "status": "absent",
    "subject": "Biology",
    "time": "09:15 AM",
    "teacher": "Dr. Taylor"
  },
  {
    "date": "2025-01-14",
    "status": "present",
    "subject": "History",
    "time": "11:00 AM",
    "teacher": "Mr. Davis"
  },
  {
    "date": "2025-01-14",
    "status": "late",
    "subject": "Chemistry",
    "time": "02:30 PM",
    "teacher": "Dr. Wilson"
  },
  {
    "date": "2025-01-13",
    "status": "present",
    "subject": "Computer Science",
    "time": "08:45 AM",
    "teacher": "Prof. Anderson"
  },
  {
    "date": "2025-01-13",
    "status": "present",
    "subject": "Mathematics",
    "time": "10:00 AM",
    "teacher": "Dr. Smith"
  },
  {
    "date": "2025-01-13",
    "status": "present",
    "subject": "English",
    "time": "01:30 PM",
    "teacher": "Ms. Brown"
  },
  {
    "date": "2025-01-12",
    "status": "late",
    "subject": "History",
    "time": "09:00 AM",
    "teacher": "Mr. Davis"
  },
  {
    "date": "2025-01-12",
    "status": "present",
    "subject": "Physics",
    "time": "11:00 AM",
    "teacher": "Prof. Johnson"
  },
  {
    "date": "2025-01-12",
    "status": "absent",
    "subject": "Biology",
    "time": "03:00 PM",
    "teacher": "Dr. Taylor"
  },
  {
    "date": "2025-01-11",
    "status": "present",
    "subject": "Chemistry",
    "time": "08:30 AM",
    "teacher": "Dr. Wilson"
  },
  {
    "date": "2025-01-11",
    "status": "present",
    "subject": "Computer Science",
    "time": "12:00 PM",
    "teacher": "Prof. Anderson"
  },
  {
    "date": "2025-01-11",
    "status": "present",
    "subject": "English",
    "time": "02:00 PM",
    "teacher": "Ms. Brown"
  },
  {
    "date": "2025-01-10",
    "status": "absent",
    "subject": "Mathematics",
    "time": "09:00 AM",
    "teacher": "Dr. Smith"
  },
  {
    "date": "2025-01-10",
    "status": "present",
    "subject": "History",
    "time": "11:30 AM",
    "teacher": "Mr. Davis"
  },
  {
    "date": "2025-01-10",
    "status": "late",
    "subject": "Physics",
    "time": "01:45 PM",
    "teacher": "Prof. Johnson"
  },
  {
    "date": "2025-01-09",
    "status": "present",
    "subject": "Computer Science",
    "time": "09:30 AM",
    "teacher": "Prof. Anderson"
  },
  {
    "date": "2025-01-09",
    "status": "present",
    "subject": "Biology",
    "time": "11:00 AM",
    "teacher": "Dr. Taylor"
  },
  {
    "date": "2025-01-09",
    "status": "present",
    "subject": "Chemistry",
    "time": "02:30 PM",
    "teacher": "Dr. Wilson"
  }
]

  
};

static Map<String, dynamic> homeworkJson = {
  "status": true,
  "message": "Attendance records fetched successfully",
  "data": [
    {
      "date": "2025-01-15",
      "status": "present",
      "subject": "Mathematics",
      "time": "09:00 AM",
      "teacher": "Dr. Smith"
    },
    {
      "date": "2025-01-14",
      "status": "absent",
      "subject": "Physics",
      "time": "10:30 AM",
      "teacher": "Prof. Johnson"
    },
    {
      "date": "2025-01-13",
      "status": "present",
      "subject": "Chemistry",
      "time": "11:45 AM",
      "teacher": "Dr. Wilson"
    },
    {
      "date": "2025-01-12",
      "status": "late",
      "subject": "English",
      "time": "02:00 PM",
      "teacher": "Ms. Brown"
    },
    {
      "date": "2025-01-11",
      "status": "present",
      "subject": "History",
      "time": "03:15 PM",
      "teacher": "Mr. Davis"
    },
    {
      "date": "2025-01-10",
      "status": "absent",
      "subject": "Biology",
      "time": "01:00 PM",
      "teacher": "Dr. Taylor"
    },
    {
      "date": "2025-01-09",
      "status": "present",
      "subject": "Computer Science",
      "time": "09:30 AM",
      "teacher": "Prof. Anderson"
    }
  ],
};
static Map<String, dynamic> downloadJson = {
  "status": true,
  "message": "Question papers fetched successfully",
  "data": [
    {
      "id": "1",
      "title": "Mathematics Final Exam",
      "subject": "Mathematics",
      "year": "2023",
      "semester": "Fall",
      "fileSize": "2.5 MB",
      "uploadDate": "2023-12-15",
      "isDownloaded": true
    },
    {
      "id": "2",
      "title": "Physics Midterm",
      "subject": "Physics",
      "year": "2023",
      "semester": "Spring",
      "fileSize": "1.8 MB",
      "uploadDate": "2023-06-20",
      "isDownloaded": false
    },
    {
      "id": "3",
      "title": "Chemistry Lab Report",
      "subject": "Chemistry",
      "year": "2023",
      "semester": "Fall",
      "fileSize": "3.2 MB",
      "uploadDate": "2023-11-10",
      "isDownloaded": false
    },
    {
      "id": "4",
      "title": "Computer Science Final",
      "subject": "Computer Science",
      "year": "2022",
      "semester": "Fall",
      "fileSize": "4.1 MB",
      "uploadDate": "2022-12-18",
      "isDownloaded": true
    },
    {
      "id": "5",
      "title": "English Literature Essay",
      "subject": "English",
      "year": "2023",
      "semester": "Spring",
      "fileSize": "1.2 MB",
      "uploadDate": "2023-05-25",
      "isDownloaded": false
    }
  ]
};
static Map<String, dynamic> leaveRequestJson = {
  "status": true,
  "message": "Leave requests fetched successfully",
  "data": [
    {
      "id": "LR001",
      "type": "Casual",
      "fromDate": "2023-12-01",
      "toDate": "2023-12-03",
      "reason": "Personal work and family commitments"
    },
    {
      "id": "LR002",
      "type": "Sick",
      "fromDate": "2023-11-15",
      "toDate": "2023-11-16",
      "reason": "Fever and flu symptoms"
    },
    {
      "id": "LR003",
      "type": "Paid",
      "fromDate": "2023-10-25",
      "toDate": "2023-10-27",
      "reason": "Wedding ceremony attendance"
    },
    {
      "id": "LR004",
      "type": "Unpaid",
      "fromDate": "2023-09-10",
      "toDate": "2023-09-12",
      "reason": "Extended personal leave for family emergency"
    },
    {
      "id": "LR005",
      "type": "Casual",
      "fromDate": "2023-08-20",
      "toDate": "2023-08-20",
      "reason": "Medical appointment and personal errands"
    }
  ]
};
static Map<String, dynamic> booksJson = {
  "status": true,
  "message": "Books fetched successfully",
  "data": [
    {
      "title": "Flutter for Beginners",
      "author": "John Doe",
      "available": true
    },
    {
      "title": "Mastering Dart",
      "author": "Jane Smith",
      "available": false
    },
    {
      "title": "Mobile App UI Design",
      "author": "Emily Clark",
      "available": true
    }
  ]
};


}

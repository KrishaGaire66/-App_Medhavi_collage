// Rest of the code remains the same as in the original file
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:medhavi/screen/assignmentscreen/components/assignmentscreen.dart';
import 'package:medhavi/screen/attendancescreen/components/attendance_screen.dart';
import 'package:medhavi/screen/downloadscreen/components/download_screen.dart';
import 'package:medhavi/screen/homeworkscreen/components/homeworkscreen.dart';
import 'package:medhavi/screen/leavenotescreen/components/leave_screen.dart';
import 'package:medhavi/screen/libraryscreen/components/libraryscreen.dart';
import 'package:medhavi/screen/menuitems/components/menu_items.dart';
import 'package:medhavi/screen/readingmaterial/components/readingmaterialscreen.dart';

import 'package:medhavi/utils/colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late String userName;
  late String greeting;

  @override
  void initState() {
    super.initState();
    var authBox = Hive.box('authBox');
    userName = authBox.get('name') ?? 'User';
    greeting = _getGreeting();
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    
    if (hour >= 5 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon';
    } else if (hour >= 17 && hour < 21) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Blue Header
          Container(
            height: 160,
            decoration: const BoxDecoration(
              gradient: linearGradient,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Row(
                children: [
                  Image.asset("assets/images/logo.png", height: 80, width: 70),
                  const SizedBox(width: 10),
                  const Text(
                    'Medhavi college',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Overlapping Card
          Transform.translate(
            offset: const Offset(0, -30),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  height: 120,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$greeting, $userName',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Attendance: 83.3% (Present Days: 5)',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.event, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            'Upcoming event: Singing Competition',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Space after card
          // const SizedBox(height: 10),

          // Menu Items below the card
          ListView.builder(
            shrinkWrap: true,
            physics:
                NeverScrollableScrollPhysics(), // so it doesn't conflict with SingleChildScrollView
            itemCount: menuItems.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                child: ListTile(
                  leading: Icon(menuItems[index].icon, color: primaryColor),
                  title: Text(menuItems[index].title),
                  subtitle: Text(menuItems[index].subtitle),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: primaryColor,
                  ),
                  onTap: () {
                    // Handle navigation or action
                    switch (menuItems[index].title) {
                      case 'Assignments':
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AssignmentScreen(),
                          ),
                        );
                        break;
                      case 'Attendance':
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AttendanceScreen(),
                          ),
                        );
                        break;
                      case 'Homework':
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>  HomeworkScreen(),
                          ),
                        );
                        break;
                      case 'Reading Materials':
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const Readingmaterialscreen(),
                          ),
                        );
                        break;
                      case 'Library':
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>  LibraryScreen(),
                          ),
                        );
                        break;
                      case 'Downloads':
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const DownloadScreen(),
                          ),
                        );
                        break;
                      case 'Leave Note':
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LeaveScreen(),
                          ),
                        );
                        break;
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
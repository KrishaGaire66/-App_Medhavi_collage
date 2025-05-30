import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:medhavi/screen/dashboard.dart';
import 'package:medhavi/screen/login_screen.dart';
import 'package:medhavi/screen/main_activity.dart';
import 'package:medhavi/screen/profilescreen.dart';
import 'package:medhavi/utils/colors.dart';
import 'package:medhavi/screen/signup_screen.dart';

class HomeScreen extends StatefulWidget {
  
  const HomeScreen({super.key});
  

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    final Box _authBox = Hive.box('authBox');
    late String userName;

@override
void initState() {
  super.initState();
  userName = _authBox.get('name') ?? 'User'; // fallback to 'User' if null
}

  int selectedIndex = 2; // Dashboard selected by default
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(gradient: linearGradient),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(color: Colors.transparent),
                    child: Image.asset(
                      "assets/images/logo.png",
                      height: 80,
                      width: 70,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Medhavi College',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.file_copy, color: primaryColor),
              title: const Text('Privacy Policy'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  selectedIndex = 2;
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit_document, color: primaryColor),
              title: const Text('Term & Conditions'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  selectedIndex = 4;
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.question_answer_rounded, color: primaryColor),
              title: const Text('FAQ'),
              onTap: () {
                Navigator.pop(context);
                // Add settings navigation logic
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.red),
              title: const Text('Logout'),
              onTap: () {
                _showExitDialog(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
  backgroundColor: Colors.white,
  elevation: 0,
  leading: IconButton(
    icon: const Icon(Icons.door_front_door, color: primaryColor),
    onPressed: () => _scaffoldKey.currentState?.openDrawer(),
  ),
  title: const Row(
    children: [
      Text(
        'Medhavi',
        style: TextStyle(
          color: primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  ),
  actions: [
    IconButton(
      icon: const Icon(Icons.person, color: primaryColor), // Changed to profile icon
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  ProfileScreen()),
        );
      },
    ),
  ],
),

      body: DashboardScreen(),
    );
  }

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () {
              _authBox.delete('token'); // Remove token
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            ),
          ],
        );
      },
    );
  }
}

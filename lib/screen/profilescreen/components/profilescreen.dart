import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:medhavi/screen/profileeditscreen/profileeditscreen.dart';
import 'package:medhavi/utils/colors.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String name;
  late String email;
  late String phone;
  late String faculty;

  @override
  void initState() {
    super.initState();
    var authBox = Hive.box('authBox');
    name = authBox.get('name') ?? 'user';
    email = authBox.get('email') ?? 'email';
    phone = authBox.get('phone') ?? '9819999099';
    faculty = authBox.get('faculty') ?? 'BCIS';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  backgroundColor: Colors.transparent, // Let the gradient show
  elevation: 0,
  centerTitle: true,
  title: Text(
    'Profile',
    style: TextStyle(
      color: primaryColor,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
  ),
  automaticallyImplyLeading: true,
  flexibleSpace: Container(
    decoration: BoxDecoration(
      gradient: linearGradient1, // 👈 Use your predefined gradient
    ),
  ),
),


      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blue,
                  child: CircleAvatar(
                    radius: 48,
                    backgroundImage: AssetImage('assets/images/logo.png'),
                  ),
                ),
                Positioned(
                  right: 4,
                  bottom: 4,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const FaIcon(
                        FontAwesomeIcons.pen,
                        color: Colors.blue,
                        size: 12,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileEditscreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              'DNSMSBT02576',
            ), // If this is dynamic too, fetch from Hive
            Text(email),
            Text(phone),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                gradient: linearGradient1,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Navigate to Detail Page
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'View Details',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            SizedBox(height: 20),
            _buildOption(FontAwesomeIcons.lock, 'Manage Password', () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        child: FaIcon(icon, color: primaryColor),
      ),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}

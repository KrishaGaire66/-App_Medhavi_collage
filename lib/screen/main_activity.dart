import 'package:flutter/material.dart';
import 'package:medhavi/connectivity/example_internet_check.dart';
import 'package:medhavi/screen/calenderscreen/components/calender_screen.dart';
import 'package:medhavi/screen/calenderscreen/components/calenderscreen.dart';
import 'package:medhavi/screen/feesccreen/components/feesscreen.dart';
import 'package:medhavi/screen/homescreen/components/home_screen.dart';
import 'package:medhavi/screen/menuitems/components/menuscreen.dart';
import 'package:medhavi/screen/noticescreen/components/noticescreen.dart';


class MainActivity extends StatefulWidget {
  const MainActivity({super.key});

  @override
  State<MainActivity> createState() => MainActivityState();
}

class MainActivityState extends State<MainActivity>
    with TickerProviderStateMixin {
  int _selectedIndex = 2;

  // List of screens
  final List<Widget> _screens = [
    NoticeScreen(),
    CalendarScreen(),
     HomeScreen(),
   FeesScreen(),
  ];

  final PageController _pageController = PageController(initialPage: 2);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index); // <-- Jump to the page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: 'Notice',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.feed), label: 'Fees'),
          // BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
        ],
      ),
    );
  }
}








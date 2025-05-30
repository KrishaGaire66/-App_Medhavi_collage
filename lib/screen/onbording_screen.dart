import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:medhavi/hive/hive_service.dart';
import 'package:medhavi/routes/routes.dart';
import 'package:medhavi/screen/home_screen.dart';
import 'package:medhavi/screen/login_screen.dart';
import 'package:medhavi/utils/colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  final List<Map<String, dynamic>> pages = [
    {
      'image':
          'https://images.pexels.com/photos/2381069/pexels-photo-2381069.jpeg?auto=compress&cs=tinysrgb&w=600',
      'color': Colors.blue.withOpacity(0.4),
      'title': 'Unlock Your Future with Medhavi',
      'subtitle':
          'Discover top-notch education, state-of-the-art facilities, and a community that nurtures your growth.',
    },
    {
      'image':
          'https://images.pexels.com/photos/30063042/pexels-photo-30063042/free-photo-of-charming-parisian-cafe-terrace-in-springtime.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
      'color': Colors.green.withOpacity(0.4),
      'title': 'Learn, Connect, Grow',
      'subtitle':
          'Access courses, join vibrant student communities, and participate in hands-on projects that build real-world skills.',
    },
    {
      'image':
          'https://images.pexels.com/photos/3157285/pexels-photo-3157285.jpeg?auto=compress&cs=tinysrgb&w=600',
      'color': Colors.deepPurple.withOpacity(0.4),
      'title': 'Join the Medhavi Community',
      'subtitle':
          'Stay connected with faculty, get real-time updates, and never miss an important event or notification.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Image.network(
                pages[currentIndex]['image'],
                key: ValueKey<int>(currentIndex),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Overlay color
          Positioned.fill(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              color: pages[currentIndex]['color'],
            ),
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged:
                        (index) => setState(() => currentIndex = index),
                    itemCount: pages.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              pages[index]['title']!,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 15),
                            Text(
                              pages[index]['subtitle']!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Page Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(pages.length, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      height: 10,
                      width: currentIndex == index ? 24 : 10,
                      decoration: BoxDecoration(
                        color:
                            currentIndex == index ? Colors.white : Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 30),

                // Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (currentIndex == pages.length - 1) {
                          // ✅ Save onboarding complete flag in Hive
                          await HiveService.saveData('isOnboarded', true);

                          final token = HiveService.getData('token');

                          if (token != null) {
                           
                            Navigator.pushReplacementNamed(
                              context,
                              Routes.home,
                            );
                          } else {
                           Navigator.pushReplacementNamed(
                              context,
                              Routes.login,
                            );
                          
                          }
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            currentIndex % 2 == 0
                                ? secondaryColor
                                : primaryColor,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: Text(
                        currentIndex == pages.length - 1
                            ? "Get Started"
                            : "Next",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

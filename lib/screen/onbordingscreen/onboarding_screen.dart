import 'package:flutter/material.dart';
import 'package:medhavi/hive/hive_service.dart';
import 'package:medhavi/routes/routes.dart';
import 'package:medhavi/screen/onbordingscreen/components/widgets/onboarding_button.dart';
import 'package:medhavi/screen/onbordingscreen/components/widgets/onboarding_page.dart';
import 'package:medhavi/screen/onbordingscreen/components/widgets/page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
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
          Positioned.fill(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              color: pages[currentIndex]['color'],
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) =>
                        setState(() => currentIndex = index),
                    itemCount: pages.length,
                    itemBuilder: (context, index) => OnboardingPage(
                      title: pages[index]['title'],
                      subtitle: pages[index]['subtitle'],
                    ),
                  ),
                ),
                PageIndicator(currentIndex: currentIndex, count: pages.length),
                const SizedBox(height: 30),
                OnboardingButton(
                  isLast: currentIndex == pages.length - 1,
                  currentIndex: currentIndex,
                  onNext: () => _pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  ),
                  onDone: () async {
                    await HiveService.saveData('isOnboarded', true);
                    final token = HiveService.getData('token');
                    Navigator.pushReplacementNamed(
                        context, token != null ? Routes.home : Routes.login);
                  },
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

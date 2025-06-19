import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medhavi/screen/animation/blury_route.dart';
import 'package:medhavi/screen/assignmentscreen/components/assignmentscreen.dart';
import 'package:medhavi/screen/homescreen/components/home_screen.dart';
import 'package:medhavi/screen/loginscreen/components/login_screen.dart';
import 'package:medhavi/screen/main_activity.dart';
import 'package:medhavi/screen/onbordingscreen/onboarding_screen.dart';
import 'package:medhavi/screen/profileeditscreen/profileeditscreen.dart';
import 'package:medhavi/screen/profilescreen/components/profilescreen.dart';
import 'package:medhavi/screen/signupscreen/components/signup_screen.dart';
import 'package:medhavi/screen/splasscreen/components/splash_screen.dart';




class Routes {
  //private constructor
  Routes._();

  static const splash = 'splash';
  static const onboarding = 'onboarding';
  static const login = 'login';
  static const profile = 'profile';
  static const signup = 'signup';
  static const main = 'main';
  static const forgetPassword = 'change-password';

  static const home = 'home_screen';
  static const blogDetail = 'blog_detail';
  static const profileSettings = 'profileSettings';
  static const profileEdit = 'profileEdit';
  static const support = 'support';
  static const knowledgeBase = 'knowledgebase';
  static const filterScreen = 'filterScreen';
  static const notificationPage = 'notificationpage';
  static const notificationDetailPage = 'notificationdetailpage';
  static const transactionHistory = 'transactionHistory';
  static const favoritesScreen = 'favoritescreen';
  static const searchScreenRoute = '/searchScreenRoute';
  static const assignmentscreen = 'assignmentscreen';
  static const attendancescreen = 'attendancescreen';
  static const homeScreen = 'homeScreen';
  static const readingmaterialscreen= 'readingmaterialscreen';
  static const libraryScreen = 'libraryScreen';
  static const downloadscreen = 'downloadscreen';
  static const leavenotescreen = 'leavenotescreen';








  static String currentRoute = splash;
  static String previousCustomerRoute = splash;

  static Route? onGenerateRouted(RouteSettings routeSettings) {
    previousCustomerRoute = currentRoute;
    currentRoute = routeSettings.name ?? '';
    log('CURRENT ROUTE $currentRoute');

    ///This is to prevent infinity loading while login browser
    if (routeSettings.name!.contains('/link?')) {
      return null;
    }

    switch (routeSettings.name) {
      case '':
        break;

      case splash:
        return BlurredRouter(builder: (context) => const SplashScreen());
      case onboarding:
        return CupertinoPageRoute(
          builder: (context) => const OnboardingScreen(),
        );
      // case home:
      //   return CupertinoPageRoute(
      //     builder: (context) => const HomeScreen(
      //   //    from: 'main',
      //     ),
      //   );
      case main:
         return CupertinoPageRoute(
          builder: (context) => MainActivity(),
        );
        case assignmentscreen:
         return CupertinoPageRoute(
          builder: (context) => AssignmentScreen(),
        );
      case login:
        return CupertinoPageRoute(
          builder: (context) => LoginScreen(),
        );
      case profile:
        return CupertinoPageRoute(
          builder: (context) => ProfileScreen(),
        );
      case signup:
        return CupertinoPageRoute(
          builder: (context) => const SignupScreen(),
        );
      case blogDetail:
        return CupertinoPageRoute(
          builder: (context) => const SignupScreen(),
        );
      case profileEdit:
        return CupertinoPageRoute(
          builder: (context) => const ProfileEditscreen(),
        );
      // case forgetPassword:
      //   return CupertinoPageRoute(
      //       builder: (context) => WebViewScreen(url: Api.apiForgetPassword));
      // case searchScreenRoute:
      //   return SearchScreen.route(routeSettings);
      // case favoritesScreen:
      //   return CupertinoPageRoute(
      //     builder: (context) => const FavoriteScreen(),
      //   );

      default:
        return BlurredRouter(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('pageNotFoundErrorMsg'),
            ),
          ),
        );
    }
    return null;
  }
}
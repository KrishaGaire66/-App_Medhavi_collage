// import 'dart:developer';

// import 'package:flutter/cupertino.dart';
// import 'package:hive_flutter/adapters.dart';

// import 'hive_key.dart';

// class HiveUtils {
//   HiveUtils._();

//   static dynamic initBoxes() async {
//     await Hive.initFlutter();
//     await Hive.openBox(HiveKey.authBox);
//     // await Hive.openBox(HiveKey.userDetailsBox);
//     // await Hive.openBox(HiveKey.languageBox);
//     // await Hive.openBox(HiveKeys.themeBox);
//     // await Hive.openBox(HiveKeys.svgBox);
//     // await Hive.openBox(HiveKeys.themeColorBox);
//   }

//   static String? getJWT() {
//     return Hive.box(HiveKeys.userDetailsBox).get(HiveKeys.jwtToken);
//   }

//   static void dontShowChooseLocationDialoge() {
//     Hive.box(HiveKeys.userDetailsBox).put('showChooseLocationDialoge', false);
//   }

//   static bool isGuest() {
//     return Hive.box(HiveKeys.userDetailsBox).get('isGuest') ?? true;
//   }

//   static void setAppThemeSetting(Map<String, dynamic> data) {
//     Hive.box(HiveKeys.themeColorBox).putAll(data);
//   }

//   static Map<String, dynamic> getAppThemeSettings() {
//     return Map<String, dynamic>.from(Hive.box(HiveKeys.themeColorBox).toMap());
//   }

//   static void setIsNotGuest() {
//     Hive.box(HiveKeys.userDetailsBox).put('isGuest', false);
//   }

//   static void setIsGuest() {
//     Hive.box(HiveKeys.userDetailsBox).put('isGuest', true);
//   }

//   static bool isShowChooseLocationDialoge() {
//     final value = Hive.box(HiveKeys.userDetailsBox).get(
//       'showChooseLocationDialoge',
//     );

//     if (value == null) {
//       return true;
//     }
//     return false;
//   }

//   static String? getUserId() {
//     if (Hive.box(HiveKeys.userDetailsBox).get('id') == null) {
//       return null;
//     }
//     return Hive.box(HiveKeys.userDetailsBox).get('id').toString();
//   }

//   static AppTheme getCurrentTheme() {
//     final current = Hive.box(HiveKeys.themeBox).get(HiveKeys.currentTheme);

//     if (current == null) {
//       return AppTheme.light;
//     }
//     if (current == 'light') {
//       return AppTheme.light;
//     }
//     if (current == 'dark') {
//       return AppTheme.dark;
//     }
//     return AppTheme.light;
//   }

//   static Future<void> setProfileNotCompleted() async {
//     await Hive.box(HiveKeys.userDetailsBox)
//         .put(HiveKeys.isProfileCompleted, false);
//   }

//   static void setCurrentTheme(AppTheme theme) {
//     String newTheme;
//     if (theme == AppTheme.light) {
//       newTheme = 'light';
//     } else {
//       newTheme = 'dark';
//     }
//     Hive.box(HiveKeys.themeBox).put(HiveKeys.currentTheme, newTheme);
//   }

//   static Future<void> setUserData(Map data) async {
//     await Hive.box(HiveKeys.userDetailsBox).putAll(data);
//   }

// /*  static LoginType getUserLoginType() {
//     return LoginType.values.firstWhere(
//       (element) =>
//           element.name == "email",
//          // element.name == Hive.box(HiveKeys.userDetailsBox).get('type'),
//     );
//   }*/
//   static LoginType getUserLoginType() {
//     return LoginType.email;
//     /* .firstWhere(
//           (element) =>
//       element.name == Hive.box(HiveKeys.userDetailsBox).get('type'),
//     );*/
//   }

//   static dynamic getCityName() {
//     return Hive.box(HiveKeys.userDetailsBox).get(HiveKeys.city);
//   }

//   static dynamic getCityPlaceId() {
//     return Hive.box(HiveKeys.userDetailsBox).get(HiveKeys.cityPlaceId);
//   }

//   static dynamic getStateName() {
//     return Hive.box(HiveKeys.userDetailsBox).get(HiveKeys.stateKey);
//   }

//   static dynamic getCountryName() {
//     return Hive.box(HiveKeys.userDetailsBox).get(HiveKeys.countryKey);
//   }

//   static Future<void> setJWT(String token) async {
//     await Hive.box(HiveKeys.userDetailsBox).put(HiveKeys.jwtToken, token);
//   }

//   static AuthModel getUserDetails() {
//     return AuthModel.fromJson(
//       Map.from(Hive.box(HiveKeys.userDetailsBox).toMap()),
//     );
//   }

//   static void setUserIsAuthenticated() {
//     Hive.box(HiveKeys.authBox).put(HiveKeys.isAuthenticated, true);
//   }

//   static Future<void> setUserIsNotAuthenticated() async =>
//       Hive.box(HiveKeys.authBox).put(HiveKeys.isAuthenticated, false);

//   static Future<void> setUserIsNotNew() {
//     Hive.box(HiveKeys.authBox).put(HiveKeys.isAuthenticated, true);
//     return Hive.box(HiveKeys.authBox).put(HiveKeys.isUserFirstTime, false);
//   }

//   static bool isLocationFilled() {
//     final city = Hive.box(HiveKeys.userDetailsBox).get(HiveKeys.city);
//     final state = Hive.box(HiveKeys.userDetailsBox).get(HiveKeys.stateKey);
//     final country = Hive.box(HiveKeys.userDetailsBox).get(HiveKeys.countryKey);

//     if (city == null && state == null && country == null) {
//       return false;
//     } else {
//       return true;
//     }
//   }

//   static Future<bool> storeLanguage(
//     dynamic data,
//   ) async {
//     await Hive.box(HiveKeys.languageBox).put(HiveKeys.currentLanguageKey, data);
//     // ..put("language", data.dart);
//     return true;
//   }

//   static dynamic getLanguage() {
//     return Hive.box(HiveKeys.languageBox).get(HiveKeys.currentLanguageKey);
//   }

//   @visibleForTesting
//   static Future<void> setUserIsNew() {
//     //Only testing purpose // not in production
//     Hive.box(HiveKeys.authBox).put(HiveKeys.isAuthenticated, false);
//     return Hive.box(HiveKeys.authBox).put(HiveKeys.isUserFirstTime, true);
//   }

//   static bool isUserAuthenticated() {
//     return Hive.box(HiveKeys.authBox).get(HiveKeys.isAuthenticated) ?? false;
//   }

//   static bool isUserFirstTime() {
//     return Hive.box(HiveKeys.authBox).get(HiveKeys.isUserFirstTime) ?? true;
//   }

//   static Future<void> logoutUser(
//     context, {
//     required VoidCallback onLogout,
//     bool? isRedirect,
//   }) async {
//     try {
//       final loginType = HiveUtils.getUserLoginType();

//       // Ensure Hive box is open before attempting to clear
//       if (!Hive.isBoxOpen(HiveKeys.userDetailsBox)) {
//         log("Error: Hive box '${HiveKeys.userDetailsBox}' is not open.");
//         return;
//       }

//       // Perform logout operations
//       await setUserIsNotAuthenticated();
//       await Hive.box(HiveKeys.userDetailsBox).clear();
//       onLogout.call();
//       await HiveUtils.setUserIsNotAuthenticated();
//       await HiveUtils.clear();

//       // Handle redirection
//       if (isRedirect ?? true) {
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           Navigator.pushReplacementNamed(context, Routes.login);
//         });
//       }

//       log("User successfully logged out.");
//     } catch (e, stackTrace) {
//       log("Issue while logout: $e");
//       log("StackTrace: $stackTrace");

//       // Handle redirection even if an error occurs
//       if (isRedirect ?? true) {
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           Navigator.pushReplacementNamed(context, Routes.login);
//         });
//       }
//     }
//   }

//   static Future<void> clear() async {
//     await Hive.box(HiveKeys.userDetailsBox).clear();
//   }
// }
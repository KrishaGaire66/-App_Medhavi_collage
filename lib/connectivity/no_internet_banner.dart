// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';

// class NoInternetBanner extends StatefulWidget {
//   final Widget child;

//   const NoInternetBanner({super.key, required this.child});

//   @override
//   State<NoInternetBanner> createState() => _NoInternetBannerState();
// }

// class _NoInternetBannerState extends State<NoInternetBanner> {
//   late StreamSubscription<ConnectivityResult> _subscription;
//   bool _isConnected = true;

//   @override
//   void initState() {
//     super.initState();
//     _initConnectivityListener();
//     _checkInitialStatus();
//   }

// late final StreamSubscription<ConnectivityResult> _subscription;

// void _initConnectivityListener() {
// _subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
//   final isConnected = results.any((r) => r != ConnectivityResult.none);
//   setState(() {
//     _isConnected = isConnected;
//   });
// });

// }


//   Future<void> _checkInitialStatus() async {
//     final result = await Connectivity().checkConnectivity();
//     setState(() {
//       _isConnected = result != ConnectivityResult.none;
//     });
//   }

//   @override
//   void dispose() {
//     _subscription.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         widget.child,
//         if (!_isConnected)
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               color: Colors.red,
//               padding: const EdgeInsets.all(8),
//               child: const Text(
//                 "No Internet Connection",
//                 style: TextStyle(color: Colors.white),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }

// import 'dart:async';
// import 'package:connectivity_plus/connectivity_plus.dart';

// class ConnectivityService {
//   final Connectivity _connectivity = Connectivity();
//   final StreamController<bool> _controller = StreamController<bool>.broadcast();

//   ConnectivityService() {
//     _connectivity.onConnectivityChanged.listen((result) {
//       _controller.add(_isConnected(result));
//     });

//     // Check current connectivity initially
//     _connectivity.checkConnectivity().then((result) {
//       _controller.add(_isConnected(result));
//     });
//   }

//   Stream<bool> get connectivityStream => _controller.stream;

//   bool _isConnected(ConnectivityResult result) {
//     return result == ConnectivityResult.mobile || result == ConnectivityResult.wifi;
//   }

//   void dispose() {
//     _controller.close();
//   }
// }

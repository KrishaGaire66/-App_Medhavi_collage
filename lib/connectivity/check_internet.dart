import 'package:connectivity_plus/connectivity_plus.dart';

class CheckInternet {
  static final Connectivity _connectivity = Connectivity();

  /// Checks current internet connectivity
  /// 
  /// - Calls [onInternet] if internet is available
  /// - Calls [onNoInternet] if no connection (optional)
  static Future<void> check({
    required Function() onInternet,
    Function()? onNoInternet,
  }) async {
    final List<ConnectivityResult> result = await _connectivity.checkConnectivity();
    if (result.any((r) => r != ConnectivityResult.none)) {
      onInternet();
    } else {
      onNoInternet?.call();
    }
  }
}

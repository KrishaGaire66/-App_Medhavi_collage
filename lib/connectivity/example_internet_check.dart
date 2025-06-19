import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NoInternetWidget extends StatelessWidget {
  final VoidCallback onRetry;
  final String message;
  final String imagePath;

  const NoInternetWidget({
    super.key,
    required this.onRetry,
    this.message = "No Internet Connection",
    this.imagePath = 'assets/images/loading.png',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 150,
            height: 150,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.wifi_off, size: 80),
          ),
          const SizedBox(height: 20),
          Text(
            message,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }
}



class InternetHandler extends StatefulWidget {
  final Widget Function(BuildContext context) builder;

  const InternetHandler({super.key, required this.builder});

  @override
  State<InternetHandler> createState() => _InternetHandlerState();
}

class _InternetHandlerState extends State<InternetHandler> {
  bool _hasInternet = true;

  @override
  void initState() {
    super.initState();
    _checkInternet();
  }

  Future<void> _checkInternet() async {
    final results = await Connectivity().checkConnectivity();
    final isConnected = results.any((r) => r != ConnectivityResult.none);
    setState(() {
      _hasInternet = isConnected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _hasInternet
        ? widget.builder(context)
        : NoInternetWidget(onRetry: _checkInternet);
  }
}

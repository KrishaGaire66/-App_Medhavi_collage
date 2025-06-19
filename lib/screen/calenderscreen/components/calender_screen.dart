import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medhavi/connectivity/example_internet_check.dart';
import 'package:medhavi/screen/calenderscreen/components/widget/calendar_controller.dart';
import 'package:medhavi/screen/calenderscreen/components/widget/calender_widgets.dart';
import 'package:medhavi/utils/colors.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  late final CalendarController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController(ref);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final calenderAsync = ref.watch(_controller.provider);

    return InternetHandler(
      builder: (context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Calendar'),
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: linearGradient1),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: calenderAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => Center(child: Text('Error: $err')),
          data: (response) {
            _controller.buildEventsFromData(response.data ?? []);
            return CalendarView(controller: _controller);
          },
        ),
      ),
    );
  }
}

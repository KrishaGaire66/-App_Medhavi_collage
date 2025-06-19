import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:medhavi/models/calender_model.dart';
import 'package:medhavi/provider/calender_provider.dart';

class CalendarController {
  final WidgetRef ref;

  CalendarController(this.ref);

  // Riverpod provider for calendar data
  FutureProvider<CalanderResponse> get provider => calenderProvider;

  // Calendar format (month, two weeks, week)
  CalendarFormat calendarFormat = CalendarFormat.month;

  // Currently focused day on the calendar
  DateTime focusedDay = DateTime.now();

  // Currently selected day
  DateTime? selectedDay;

  // Holds all events by date (mapped to title list)
  Map<DateTime, List<String>> events = {};

  // Notifier for the events of the selected day
  late final ValueNotifier<List<String>> selectedEvents = ValueNotifier([]);

  /// Normalize a date (remove time) to use as map key
  DateTime normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Get the list of events for a given day
  List<String> getEventsForDay(DateTime day) {
    return events[normalizeDate(day)] ?? [];
  }

  /// Build event map from API data and update selected events
  void buildEventsFromData(List<Calender> data) {
    final Map<DateTime, List<String>> newEvents = {};

    for (var event in data) {
      if (event.eventDate == null) continue;

      final DateTime? parsedDate = DateTime.tryParse(event.eventDate!);
      if (parsedDate == null) continue;

      final DateTime normalizedDate = normalizeDate(parsedDate);

      newEvents.putIfAbsent(normalizedDate, () => []);
      newEvents[normalizedDate]!.add(event.title ?? "No Title");
    }

    events = newEvents;

    // Set initial selected day if not already set
    selectedDay ??= focusedDay;

    // Update selected events
    selectedEvents.value = getEventsForDay(selectedDay!);
  }

  /// Called when user selects a new day on the calendar
  void onDaySelected(DateTime newSelectedDay, DateTime newFocusedDay) {
    if (!isSameDay(selectedDay, newSelectedDay)) {
      selectedDay = newSelectedDay;
      focusedDay = newFocusedDay;
      selectedEvents.value = getEventsForDay(newSelectedDay);
    }
  }

  /// Cleanup notifier to avoid memory leaks
  void dispose() {
    selectedEvents.dispose();
  }
}

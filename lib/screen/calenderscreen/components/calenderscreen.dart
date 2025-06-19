// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:medhavi/models/calender_model.dart';
// import 'package:medhavi/provider/calender_provider.dart';
// import 'package:medhavi/utils/colors.dart';
// import 'package:table_calendar/table_calendar.dart';

// class CalendarScreen extends ConsumerStatefulWidget {
//   const CalendarScreen({super.key});

//   @override
//   ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
// }

// class _CalendarScreenState extends ConsumerState<CalendarScreen> {
//   late final ValueNotifier<List<String>> _selectedEvents;

//   CalendarFormat _calendarFormat = CalendarFormat.month;
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;

//   Map<DateTime, List<String>> _events = {};

//   DateTime _normalizeDate(DateTime date) {
//     return DateTime(date.year, date.month, date.day);
//   }

//   List<String> _getEventsForDay(DateTime day) {
//     return _events[_normalizeDate(day)] ?? [];
//   }

//   @override
//   void initState() {
//     super.initState();
//     _selectedDay = _focusedDay;
//     _selectedEvents = ValueNotifier([]);
//   }

//   @override
//   void dispose() {
//     _selectedEvents.dispose();
//     super.dispose();
//   }

//   void _buildEventsFromData(List<Calender> data) {
//     final Map<DateTime, List<String>> events = {};

//     for (var event in data) {
//       if (event.eventDate == null) continue;

//       // Parse the date string from your model
//       final DateTime eventDate = DateTime.tryParse(event.eventDate!) ?? DateTime.now();

//       final normalizedDate = _normalizeDate(eventDate);

//       if (!events.containsKey(normalizedDate)) {
//         events[normalizedDate] = [];
//       }
//       // Use title or description as event text (choose what you prefer)
//       events[normalizedDate]!.add(event.title ?? "No Title");
//     }

//     setState(() {
//       _events = events;
//       // Update selectedEvents for the currently selected day
//       _selectedEvents.value = _getEventsForDay(_selectedDay!);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final calenderAsync = ref.watch(calenderProvider);

//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('Calendar'),
//         flexibleSpace: Container(
//           decoration: BoxDecoration(gradient: linearGradient1),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: calenderAsync.when(
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (err, _) => Center(child: Text('Error: $err')),
//         data: (response) {
//           // Build events map from your fetched data
//           _buildEventsFromData(response.data ?? []);

//           return Column(
//             children: [
//               TableCalendar(
//                 firstDay: DateTime.utc(2020, 1, 1),
//                 lastDay: DateTime.utc(2040, 12, 31),
//                 focusedDay: _focusedDay,
//                 calendarFormat: _calendarFormat,
//                 selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
//                 onDaySelected: (selectedDay, focusedDay) {
//                   if (!isSameDay(_selectedDay, selectedDay)) {
//                     setState(() {
//                       _selectedDay = selectedDay;
//                       _focusedDay = focusedDay;
//                       _selectedEvents.value = _getEventsForDay(selectedDay);
//                     });
//                   }
//                 },
//                 onFormatChanged: (format) {
//                   setState(() {
//                     _calendarFormat = format;
//                   });
//                 },
//                 eventLoader: _getEventsForDay,
//                 calendarBuilders: CalendarBuilders(
//                   selectedBuilder: (context, day, focusedDay) {
//                     final bool isSaturday = day.weekday == DateTime.saturday;
//                     return Container(
//                       margin: const EdgeInsets.all(6),
//                       decoration: BoxDecoration(
//                         color: isSaturday ? secondaryColor : primaryColor,
//                         shape: BoxShape.circle,
//                       ),
//                       alignment: Alignment.center,
//                       child: Text(
//                         '${day.day}',
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     );
//                   },
//                   defaultBuilder: (context, day, focusedDay) {
//                     if (day.weekday == DateTime.saturday) {
//                       return Center(
//                         child: Text(
//                           '${day.day}',
//                           style: const TextStyle(color: Colors.red),
//                         ),
//                       );
//                     }
//                     return null;
//                   },
//                   outsideBuilder: (context, day, focusedDay) {
//                     if (day.weekday == DateTime.saturday) {
//                       return Center(
//                         child: Text(
//                           '${day.day}',
//                           style: const TextStyle(color: Colors.redAccent),
//                         ),
//                       );
//                     }
//                     return null;
//                   },
//                   markerBuilder: (context, day, events) {
//                     if (events.isNotEmpty) {
//                       return Positioned(
//                         bottom: 4,
//                         child: Container(
//                           width: 6,
//                           height: 6,
//                           decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       );
//                     }
//                     return const SizedBox.shrink();
//                   },
//                 ),
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 'Selected Day Events',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               Expanded(
//                 child: ValueListenableBuilder<List<String>>(
//                   valueListenable: _selectedEvents,
//                   builder: (context, value, _) {
//                     if (value.isEmpty) {
//                       return const Center(
//                         child: Text("No events for this day."),
//                       );
//                     }
//                     return ListView.builder(
//                       itemCount: value.length,
//                       itemBuilder: (context, index) {
//                         return Card(
//                           margin: const EdgeInsets.symmetric(
//                             horizontal: 16,
//                             vertical: 4,
//                           ),
//                           child: ListTile(
//                             leading: const Icon(
//                               Icons.event,
//                               color: Colors.blue,
//                             ),
//                             title: Text(value[index]),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//               const Divider(thickness: 1),
//               const Text(
//                 'All Events This Month',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               Expanded(
//                 child: ListView(
//                   children: _events.entries.map((entry) {
//                     String dateString =
//                         "${entry.key.year}-${entry.key.month.toString().padLeft(2, '0')}-${entry.key.day.toString().padLeft(2, '0')}";

//                     return Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 8,
//                       ),
//                       child: Card(
//                         elevation: 2,
//                         child: ExpansionTile(
//                           title: Text(
//                             dateString,
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           children: entry.value
//                               .map((event) => ListTile(
//                                     leading: const Icon(
//                                       Icons.event_note,
//                                       color: Colors.green,
//                                     ),
//                                     title: Text(event),
//                                   ))
//                               .toList(),
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

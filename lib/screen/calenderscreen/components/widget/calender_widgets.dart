import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'calendar_controller.dart';
import 'package:medhavi/utils/colors.dart';

class CalendarView extends StatefulWidget {
  final CalendarController controller;

  const CalendarView({required this.controller, Key? key}) : super(key: key);

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  CalendarController get controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2040, 12, 31),
          focusedDay: controller.focusedDay,
          calendarFormat: controller.calendarFormat,
          selectedDayPredicate: (day) => isSameDay(controller.selectedDay, day),
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(controller.selectedDay, selectedDay)) {
              setState(() {
                controller.selectedDay = selectedDay;
                controller.focusedDay = focusedDay;
                controller.selectedEvents.value = controller.getEventsForDay(selectedDay);
              });
            }
          },
          onFormatChanged: (format) {
            setState(() {
              controller.calendarFormat = format;
            });
          },
          eventLoader: controller.getEventsForDay,
          calendarBuilders: CalendarBuilders(
            selectedBuilder: (context, day, focusedDay) {
              final bool isSaturday = day.weekday == DateTime.saturday;
              return Container(
                margin: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: isSaturday ? secondaryColor : primaryColor,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '${day.day}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
            defaultBuilder: (context, day, focusedDay) {
              if (day.weekday == DateTime.saturday) {
                return Center(
                  child: Text(
                    '${day.day}',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }
              return null;
            },
            outsideBuilder: (context, day, focusedDay) {
              if (day.weekday == DateTime.saturday) {
                return Center(
                  child: Text(
                    '${day.day}',
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                );
              }
              return null;
            },
            markerBuilder: (context, day, events) {
              if (events.isNotEmpty) {
                return Positioned(
                  bottom: 4,
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Selected Day Events',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: ValueListenableBuilder<List<String>>(
            valueListenable: controller.selectedEvents,
            builder: (context, value, _) {
              if (value.isEmpty) {
                return const Center(child: Text("No events for this day."));
              }
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: ListTile(
                      leading: const Icon(Icons.event, color: Colors.blue),
                      title: Text(value[index]),
                    ),
                  );
                },
              );
            },
          ),
        ),
        const Divider(thickness: 1),
        const Text(
          'All Events This Month',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: ListView(
            children: controller.events.entries.map((entry) {
              String dateString =
                  "${entry.key.year}-${entry.key.month.toString().padLeft(2, '0')}-${entry.key.day.toString().padLeft(2, '0')}";

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Card(
                  elevation: 2,
                  child: ExpansionTile(
                    title: Text(dateString, style: const TextStyle(fontWeight: FontWeight.bold)),
                    children: entry.value
                        .map((event) => ListTile(
                              leading: const Icon(Icons.event_note, color: Colors.green),
                              title: Text(event),
                            ))
                        .toList(),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

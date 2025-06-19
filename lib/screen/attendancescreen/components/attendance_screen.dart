import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medhavi/models/attendance_model.dart';
import 'package:medhavi/provider/attendance_provider.dart';
import 'package:medhavi/screen/attendancescreen/components/widgets/stat_card.dart';
import 'package:medhavi/utils/colors.dart';
import 'widgets/monthly_progress.dart';
import 'widgets/filter_dropdown.dart';
import 'widgets/attendance_card.dart';

class AttendanceScreen extends ConsumerStatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends ConsumerState<AttendanceScreen> {
  String selectedFilter = 'All';

  Future<void> _refresh() async {
    // Refresh the attendanceProvider to reload data
    await ref.refresh(attendanceProvider.future);
  }

  @override
  Widget build(BuildContext context) {
    final attendanceAsync = ref.watch(attendanceProvider);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(gradient: linearGradient1),
          child: AppBar(
            title: const Text('Attendance',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
        ),
      ),
      body: attendanceAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (attendanceResponse) {
          final attendance = attendanceResponse.data;
          final filteredRecords = selectedFilter == 'All'
              ? attendance ?? []
              : (attendance ?? []).where((record) {
                  switch (selectedFilter) {
                    case 'Present':
                      return record.status?.toLowerCase() == 'present';
                    case 'Absent':
                      return record.status?.toLowerCase() == 'absent';
                    case 'Late':
                      return record.status?.toLowerCase() == 'late';
                    default:
                      return true;
                  }
                }).toList();

          return RefreshIndicator(
            onRefresh: _refresh,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const StatCards(),
                  const SizedBox(height: 24),
                  const MonthlyProgress(),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Attendance Records',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      FilterDropdown(
                        selectedValue: selectedFilter,
                        onChanged: (value) => setState(() => selectedFilter = value),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  filteredRecords.isEmpty
                      ? const Center(child: Text('No records found.'))
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filteredRecords.length,
                          itemBuilder: (context, index) {
                            return AttendanceCard(record: filteredRecords[index]);
                          },
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

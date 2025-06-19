import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medhavi/screen/leavenotescreen/components/widgets/apply_leave_dialog.dart';
import 'package:medhavi/screen/leavenotescreen/components/widgets/leave_card.dart';
import 'package:medhavi/provider/leave_provider.dart';
import 'package:medhavi/models/leave_model.dart';
import 'package:medhavi/utils/colors.dart';

class LeaveScreen extends ConsumerWidget {
  const LeaveScreen({super.key});

  Future<void> _refresh(WidgetRef ref) async {
    await ref.refresh(leaveProvider.future);
  }

  /// Opens a dialog to apply a leave request.
  void _openApplyDialog(BuildContext context, WidgetRef ref) async {
    final newLeave = await showDialog<LeaveRequest>(
      context: context,
      builder: (_) => const ApplyLeaveDialog(),
    );

    // TODO: Call service to post the leave (optional, based on your setup)
    if (newLeave != null) {
      // Handle leave submission here if needed
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Leave applied (not yet submitted to backend)"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaveAsync = ref.watch(leaveProvider);

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: linearGradient1),
        ),
        title: const Text("Leave Requests"),
      ),
      body: leaveAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Error: $err")),
        data: (leaveRequest) {
          final leaveList = leaveRequest.data ?? [];

          return RefreshIndicator(
            onRefresh: () => _refresh(ref),
            child:
                leaveList.isEmpty
                    ? ListView(
                      // ListView needed here to enable RefreshIndicator on empty list
                      children: const [
                        SizedBox(height: 200),
                        Center(child: Text('No leave requests found.')),
                      ],
                    )
                    : ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: leaveList.length,
                      itemBuilder:
                          (_, index) => LeaveCard(leave: leaveList[index]),
                    ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openApplyDialog(context, ref),
        label: const Text("Apply Leave", style: TextStyle(color: Colors.white)),
        icon: const Icon(Icons.add, color: Colors.white),
        backgroundColor: primaryColor,
      ),
    );
  }
}

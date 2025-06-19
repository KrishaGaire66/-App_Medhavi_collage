import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medhavi/models/download_model.dart';
import 'package:medhavi/provider/download_provider.dart';
import 'widgets/download_appbar.dart';
import 'widgets/search_and_filter_section.dart';
import 'widgets/result_count_row.dart';
import 'widgets/question_paper_card.dart';
import 'widgets/empty_state.dart';
import 'widgets/sort_bottom_sheet.dart';

class DownloadScreen extends ConsumerStatefulWidget {
  const DownloadScreen({super.key});

  @override
  ConsumerState<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends ConsumerState<DownloadScreen> {
  String selectedFilter = 'All';
  String searchQuery = '';

  void _viewPaper(DownloadPaper paper) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('View Paper'),
        content: Text('Opening ${paper.title}...'),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('Close'))],
      ),
    );
  }

  void _downloadPaper(DownloadPaper paper) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
            SizedBox(width: 16),
            Text('Downloading ${paper.title}...'),
          ],
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showSortOptions() {
    showSortBottomSheet(context);
  }

  Future<void> _refresh() async {
    await ref.refresh(downloadPaperProvider.future);
  }

  @override
  Widget build(BuildContext context) {
    final downloadPaperAsync = ref.watch(downloadPaperProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: buildDownloadAppBar(context),
      body: downloadPaperAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (downloadResponse) {
          final papers = downloadResponse.data;

          return RefreshIndicator(
            onRefresh: _refresh,
            child: Column(
              children: [
                SearchAndFilterSection(
                  selectedFilter: selectedFilter,
                  onFilterSelected: (filter) => setState(() => selectedFilter = filter),
                  onSearchChanged: (query) => setState(() => searchQuery = query),
                ),
                ResultCountRow(count: papers.length, onSortTap: _showSortOptions),
                Expanded(
                  child: papers.isEmpty
                      ? const EmptyState()
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: papers.length,
                          itemBuilder: (context, index) => QuestionPaperCard(
                            paper: papers[index],
                            onView: _viewPaper,
                            onDownload: _downloadPaper,
                          ),
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

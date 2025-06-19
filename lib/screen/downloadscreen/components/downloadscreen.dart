// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:medhavi/models/download_model.dart';
// import 'package:medhavi/provider/download_provider.dart';

// class DownloadScreen extends ConsumerStatefulWidget {
//   const DownloadScreen({super.key});

//   @override
//   ConsumerState<DownloadScreen> createState() => _DownloadScreenState();
// }

// class _DownloadScreenState extends ConsumerState<DownloadScreen> {
//   String selectedFilter = 'All';
//   String searchQuery = '';

//   @override
//   Widget build(BuildContext context) {
//     final downloadPaperAsync = ref.watch(downloadPaperProvider);

//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         title: Text(
//           'Question Papers',
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//         backgroundColor: Colors.indigo[600],
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: () {
//               // Refresh functionality
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('Refreshing question papers...')),
//               );
//             },
//           ),
//         ],
//       ),

//       body: downloadPaperAsync.when(
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (error, _) => Center(child: Text('Error: $error')),
//         data: (downloadResponse) {
//           final downloadPaper =
//               downloadResponse.data; // List<Map<String, dynamic>>
//           return   Column(
//             children: [
//               // Search and Filter Section
//               Container(
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.1),
//                       spreadRadius: 1,
//                       blurRadius: 3,
//                       offset: Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     // Search Bar
//                     TextField(
//                       decoration: InputDecoration(
//                         hintText: 'Search question papers...',
//                         prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
//                         filled: true,
//                         fillColor: Colors.grey[100],
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide.none,
//                         ),
//                         contentPadding: EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 12,
//                         ),
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           searchQuery = value;
//                         });
//                       },
//                     ),
//                     SizedBox(height: 12),
//                     // Filter Chips
//                     SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Row(
//                         children:
//                             [
//                                   'All',
//                                   'Mathematics',
//                                   'Physics',
//                                   'Chemistry',
//                                   'Computer Science',
//                                   'English',
//                                 ]
//                                 .map(
//                                   (filter) => Padding(
//                                     padding: EdgeInsets.only(right: 8),
//                                     child: FilterChip(
//                                       label: Text(filter),
//                                       selected: selectedFilter == filter,
//                                       onSelected: (selected) {
//                                         setState(() {
//                                           selectedFilter = filter;
//                                         });
//                                       },
//                                       backgroundColor: Colors.grey[200],
//                                       selectedColor: Colors.indigo[100],
//                                       checkmarkColor: Colors.indigo[600],
//                                       labelStyle: TextStyle(
//                                         color:
//                                             selectedFilter == filter
//                                                 ? Colors.indigo[600]
//                                                 : Colors.grey[700],
//                                       ),
//                                     ),
//                                   ),
//                                 )
//                                 .toList(),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               // Results Count
//               Padding(
//                 padding: EdgeInsets.all(16),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       '${downloadPaper.length} question papers found',
//                       style: TextStyle(color: Colors.grey[600], fontSize: 14),
//                     ),
//                     TextButton.icon(
//                       onPressed: () {
//                         // Sort functionality
//                         _showSortOptions(context);
//                       },
//                       icon: Icon(Icons.sort, size: 18),
//                       label: Text('Sort'),
//                     ),
//                   ],
//                 ),
//               ),

//               // Question Papers List
//               Expanded(
//                 child:
//                     downloadPaper.isEmpty
//                         ? _buildEmptyState()
//                         : ListView.builder(
//                           padding: EdgeInsets.symmetric(horizontal: 16),
//                           itemCount: downloadPaper.length,
//                           itemBuilder: (context, index) {
//                             final paper = downloadPaper[index];
//                             return _buildQuestionPaperCard(paper);
//                           },
//                         ),
//               ),
//             ],
//           );
//           return Container(
//             child: Text('${downloadPaper.length} question papers found'),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildQuestionPaperCard(DownloadPaper paper) {
//     return Card(
//       margin: EdgeInsets.only(bottom: 12),
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(12),
//         onTap: () => _viewPaper(paper),
//         child: Padding(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: Colors.indigo[50],
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Text(
//                       paper.subject,
//                       style: TextStyle(
//                         color: Colors.indigo[600],
//                         fontSize: 12,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                   Spacer(),
//                   if (paper.isDownloaded)
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: Colors.green[50],
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(
//                             Icons.download_done,
//                             size: 12,
//                             color: Colors.green[600],
//                           ),
//                           SizedBox(width: 4),
//                           Text(
//                             'Downloaded',
//                             style: TextStyle(
//                               color: Colors.green[600],
//                               fontSize: 11,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                 ],
//               ),
//               SizedBox(height: 8),
//               Text(
//                 paper.title,
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.grey[800],
//                 ),
//               ),
//               SizedBox(height: 8),
//               Row(
//                 children: [
//                   Icon(Icons.calendar_today, size: 14, color: Colors.grey[500]),
//                   SizedBox(width: 4),
//                   Text(
//                     '${paper.semester} ${paper.year}',
//                     style: TextStyle(color: Colors.grey[600], fontSize: 13),
//                   ),
//                   SizedBox(width: 16),
//                   Icon(Icons.file_present, size: 14, color: Colors.grey[500]),
//                   SizedBox(width: 4),
//                   Text(
//                     paper.fileSize,
//                     style: TextStyle(color: Colors.grey[600], fontSize: 13),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 12),
//               Row(
//                 children: [
//                   Expanded(
//                     child: OutlinedButton.icon(
//                       onPressed: () => _viewPaper(paper),
//                       icon: Icon(Icons.visibility, size: 18),
//                       label: Text('View'),
//                       style: OutlinedButton.styleFrom(
//                         foregroundColor: Colors.indigo[600],
//                         side: BorderSide(color: Colors.indigo[300]!),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 12),
//                   Expanded(
//                     child: ElevatedButton.icon(
//                       onPressed: () => _downloadPaper(paper),
//                       icon: Icon(Icons.download, size: 18),
//                       label: Text('Download'),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.indigo[600],
//                         foregroundColor: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
//           SizedBox(height: 16),
//           Text(
//             'No question papers found',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//               color: Colors.grey[600],
//             ),
//           ),
//           SizedBox(height: 8),
//           Text(
//             'Try adjusting your search or filters',
//             style: TextStyle(color: Colors.grey[500]),
//           ),
//         ],
//       ),
//     );
//   }

//   void _viewPaper(DownloadPaper paper) {
//     // Implement view functionality
//     showDialog(
//       context: context,
//       builder:
//           (context) => AlertDialog(
//             title: Text('View Paper'),
//             content: Text('Opening ${paper.title}...'),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text('Close'),
//               ),
//             ],
//           ),
//     );
//   }

//   void _downloadPaper(DownloadPaper paper) {
//     // Implement download functionality
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Row(
//           children: [
//             CircularProgressIndicator(
//               strokeWidth: 2,
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//             ),
//             SizedBox(width: 16),
//             Text('Downloading ${paper.title}...'),
//           ],
//         ),
//         duration: Duration(seconds: 2),
//       ),
//     );

//     // Simulate download completion
//     // Future.delayed(Duration(seconds: 2), () {
//     //   setState(() {
//     //     final index = .indexWhere((p) => p.id == paper.id);
//     //     if (index != -1) {
//     //       questionPapers[index] = QuestionPaper(
//     //         id: paper.id,
//     //         title: paper.title,
//     //         subject: paper.subject,
//     //         year: paper.year,
//     //         semester: paper.semester,
//     //         fileSize: paper.fileSize,
//     //         uploadDate: paper.uploadDate,
//     //         isDownloaded: true,
//     //       );
//     //     }
//     //   });

//     //   ScaffoldMessenger.of(context).showSnackBar(
//     //     SnackBar(
//     //       content: Text('${paper.title} downloaded successfully!'),
//     //       backgroundColor: Colors.green,
//     //     ),
//     //   );
//     // });
//   }

//   void _showSortOptions(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder:
//           (context) => Container(
//             padding: EdgeInsets.all(20),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   'Sort by',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 16),
//                 ListTile(
//                   leading: Icon(Icons.date_range),
//                   title: Text('Upload Date'),
//                   onTap: () => Navigator.pop(context),
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.sort_by_alpha),
//                   title: Text('Title'),
//                   onTap: () => Navigator.pop(context),
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.folder),
//                   title: Text('Subject'),
//                   onTap: () => Navigator.pop(context),
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.calendar_today),
//                   title: Text('Year'),
//                   onTap: () => Navigator.pop(context),
//                 ),
//               ],
//             ),
//           ),
//     );
//   }
// }

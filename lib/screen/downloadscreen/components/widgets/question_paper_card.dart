import 'package:flutter/material.dart';
import 'package:medhavi/models/download_model.dart';

class QuestionPaperCard extends StatelessWidget {
  final DownloadPaper paper;
final ValueChanged<DownloadPaper> onView;
final ValueChanged<DownloadPaper> onDownload;


  const QuestionPaperCard({
    super.key,
    required this.paper,
    required this.onView,
    required this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap :() => onView(paper),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.indigo[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(paper.subject, style: TextStyle(color: Colors.indigo[600], fontSize: 12)),
                  ),
                  Spacer(),
                  if (paper.isDownloaded)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: Colors.green[50], borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          Icon(Icons.download_done, size: 12, color: Colors.green[600]),
                          SizedBox(width: 4),
                          Text('Downloaded', style: TextStyle(color: Colors.green[600], fontSize: 11)),
                        ],
                      ),
                    ),
                ],
              ),
              SizedBox(height: 8),
              Text(paper.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 14, color: Colors.grey[500]),
                  SizedBox(width: 4),
                  Text('${paper.semester} ${paper.year}', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                  SizedBox(width: 16),
                  Icon(Icons.file_present, size: 14, color: Colors.grey[500]),
                  SizedBox(width: 4),
                  Text(paper.fileSize, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed:() => onView(paper),
                      icon: Icon(Icons.visibility),
                      label: Text('View'),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed:() => onDownload(paper),
                      icon: Icon(Icons.download),
                      label: Text('Download'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

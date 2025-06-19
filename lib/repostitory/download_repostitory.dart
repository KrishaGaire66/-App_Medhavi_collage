import 'package:medhavi/models/download_model.dart';
import 'package:medhavi/service/download_service.dart';
class DownloadPaperRepostitory
{
  final DownloadService downloadService ;
  DownloadPaperRepostitory( this.downloadService);
   Future<DownloadPaperResponse> getDownloadPaper () async{
    return await downloadService.fetchDownloadPaper();

   }

}
import 'package:medhavi/models/attendance_model.dart';
import 'package:medhavi/models/library_model.dart';
import 'package:medhavi/service/attendance_service.dart';
import 'package:medhavi/service/library_service.dart';
import 'package:medhavi/utils/colors.dart';
class LibraryRepostitory
{
  final LibraryService linearGradient ;
  LibraryRepostitory( this.linearGradient);
   Future<BookResponse> getLibrary () async{
    return await linearGradient.fetchLibrary();

   }

}
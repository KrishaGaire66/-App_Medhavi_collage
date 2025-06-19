import 'package:medhavi/models/calender_model.dart';
import 'package:medhavi/service/calender_service.dart';
class CalenderRepostitory
{
  final CalenderService calenderService ;
  CalenderRepostitory( this.calenderService);
   Future<CalanderResponse> getCalender () async{
    return await calenderService.fetchEvents();

   }

}
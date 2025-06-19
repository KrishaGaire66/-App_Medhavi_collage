import 'package:medhavi/models/attendance_model.dart';
import 'package:medhavi/service/attendance_service.dart';
class AttendanceRepostitory
{
  final AttendanceService attendanceService ;
  AttendanceRepostitory( this.attendanceService);
   Future<AttendanceResponse> getCalender () async{
    return await attendanceService.fetchAttendance();

   }

}
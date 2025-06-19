import 'package:medhavi/models/leave_model.dart';
import 'package:medhavi/service/leave_service.dart';
class LeaveRepository
{
  final LeaveService leaveService ;
   LeaveRepository( this.leaveService);
   Future<LeaveResponse> getLeave () async{
    return await leaveService.fetchLeave();

   }

}
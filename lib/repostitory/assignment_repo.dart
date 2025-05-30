import 'package:medhavi/service/assignment_service.dart';
import 'package:medhavi/models/assignment_model.dart';
class AssignmentRepository
{
  final AssignmentService assignmentService ;
  AssignmentRepository( this.assignmentService);
   Future<AssignmentResponse> getAssignment () async{
    return await assignmentService.fetchAssignments();

   }

}
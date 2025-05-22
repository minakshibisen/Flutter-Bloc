import '../../model/attendance_model.dart';

abstract class AttendanceState {}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceLoaded extends AttendanceState {
  final List<AttendanceModel> attendanceList;
  AttendanceLoaded(this.attendanceList);
}

class AttendanceSuccess extends AttendanceState {}

class AttendanceFailure extends AttendanceState {
  final String error;
  AttendanceFailure(this.error);
}

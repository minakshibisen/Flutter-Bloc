import 'package:equatable/equatable.dart';

abstract class AttendanceEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class AddAttendance extends AttendanceEvent {}
class FetchAttendance extends AttendanceEvent {}


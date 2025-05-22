class AttendanceModel {
  final String type;
  final String date;
  final String time;

  AttendanceModel({
    required this.type,
    required this.date,
    required this.time,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      type: json['attendence_type'],
      date: json['attendence_date'],
      time: json['attendence_time'],
    );
  }
}

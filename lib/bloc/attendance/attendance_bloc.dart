import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import '../../model/attendance_model.dart';
import '../../repository/location_service_repo.dart';
import 'attendance_event.dart';
import 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final LocationService locationService;

  AttendanceBloc({required this.locationService}) : super(AttendanceInitial()) {
    on<AddAttendance>(_addAttendanceApi);
    on<FetchAttendance>(_fetchAttendanceApi);
  }

  Future<void> _addAttendanceApi(
      AddAttendance event, Emitter<AttendanceState> emit) async {
    emit(AttendanceLoading());

    try {
      await _addAttendanceToServer();
      emit(AttendanceSuccess());
    } catch (e) {
      emit(AttendanceFailure(e.toString()));
    }
  }

  Future<void> _fetchAttendanceApi(
      FetchAttendance event, Emitter<AttendanceState> emit) async {
    emit(AttendanceLoading());
    DateTime now = DateTime.now();

    try {
      final response = await http.post(
          Uri.parse('http://172.17.1.1/hrmsv1/gateway/get_attendance'),
          body: {
            "user_id": '1001',
            'attendance_date': '${now.day}-${now.month}-${now.year}',
          });
      print(response);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> responseList = data['response'];
        print(data);
        final List<AttendanceModel> attendanceList =
            responseList.map((json) => AttendanceModel.fromJson(json)).toList();

        emit(AttendanceLoaded(attendanceList));
      } else {
        emit(AttendanceFailure('Failed to fetch attendance.'));
      }
    } catch (e) {
      emit(AttendanceFailure(e.toString()));
    }
  }

  Future<void> _addAttendanceToServer() async {
    final position = await locationService.getCurrentPosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    final Placemark place = placemarks.first;

    final String city = place.locality ?? '';
    final String pincode = place.postalCode ?? '';
    final String address =
        '${place.name}, ${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';

    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    final AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
    final String deviceId = androidInfo.id;

    final response = await http.post(
      Uri.parse('http://172.17.1.1/hrmsv1/gateway/add_attendance'),
      body: {
        "user_id": '1001',
        'latitude': position.latitude.toString(),
        'longitude': position.longitude.toString(),
        "location": address,
        "pincode": pincode,
        "device_id": deviceId,
        "city": city,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add attendance');
    }
  }
}

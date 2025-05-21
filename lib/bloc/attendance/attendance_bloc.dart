
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import '../../repository/location_service_repo.dart';

import 'attendance_event.dart';
import 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final LocationService locationService;

  AttendanceBloc({required this.locationService}) : super(AttendanceInitial()) {
    on<AddAttendance>(_addAttendanceApi);
  }

  Future<void> _addAttendanceApi(
      AddAttendance event, Emitter<AttendanceState> emit) async {
    emit(AttendanceLoading());
    try {
      await addAttendance();
      emit(AttendanceSuccess());
    } catch (e) {
      emit(AttendanceFailure(e.toString()));
    }
  }

  Future<void> addAttendance() async {

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

    //Device add get krne ke liye

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

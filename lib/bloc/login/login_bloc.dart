import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

import '../../repository/location_service_repo.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LocationService locationService;

  LoginBloc({required this.locationService}) : super(LoginState()) {
    on<LoginApi>(_loginApi);
    on<EmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });
    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });
  }

  void _loginApi(LoginApi event, Emitter<LoginState> emit) async {
    if (state.email.isEmpty || state.password.isEmpty) {
      emit(state.copyWith(
        loginStatus: LoginStatus.error,
        message: 'Email and password must not be empty',
      ));
      return;
    }

    emit(state.copyWith(loginStatus: LoginStatus.loading, message: ''));

    try {
      final position = await locationService.getCurrentPosition();

      final response = await http.post(
        Uri.parse('http://172.17.1.1/hrmsv1/gateway/validateLogin'),
        body: {
          'email': state.email,
          'password': state.password,
          'lat': position.latitude.toString(),
          'lang': position.longitude.toString(),
        },
      );

      if (response.statusCode == 200) {
        emit(state.copyWith(
          loginStatus: LoginStatus.success,
          message: 'Login Successful',
        ));
      } else {
        emit(state.copyWith(
          loginStatus: LoginStatus.error,
          message: 'Invalid credentials',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        loginStatus: LoginStatus.error,
        message: e.toString(),
      ));
    }
  }
}

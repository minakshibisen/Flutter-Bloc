import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
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

    emit(state.copyWith(
      loginStatus: LoginStatus.loading,
      message: '',
    ));

    try {
      final response = await http.post(
        Uri.parse('http://172.17.1.1/hrmsv1/gateway/validateLogin'),
        body: {
          'email': state.email,
          'password': state.password,
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


 /* void _loginApi(LoginApi event,Emitter<LoginState>emit)async{
    emit(
      state.copyWith(
        loginStatus: LoginStatus.loading,
        message: 'Something went wrong try again',
      ),
    );
    Map data ={'email':state.email,'password':state.password,};
if (kDebugMode) {
  print(data);
}
    try{
      final response = await http.post(Uri.parse('http://172.17.1.1/hrmsv1/gateway/validateLogin'),body:data);
      // final response = await http.post(Uri.parse('https://reqres.in/api/login'),body:data);

      if (response.statusCode==200){
        emit(
          state.copyWith(
            loginStatus: LoginStatus.success,
            message: 'Login SuccessFull',
          ),
        );
      }else{
        if (kDebugMode) {
          print(response.body);
        }
        emit(
          state.copyWith(
            loginStatus: LoginStatus.error,
            message: 'Something went wrong try again',
          ),
        );
      }
    }catch(e){
      emit(
        state.copyWith(
          message: e.toString(),
        ),
      );
    }
  }*/
}


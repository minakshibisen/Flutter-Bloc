import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<EmailChanged>((event, emit) {
     emit(state.copyWith(email: event.email));
    });
    on<PasswordChanged>((event, emit) {
     emit(state.copyWith(password: event.password));
    });
    on<LoginSubmitted>((event,emit)async{
      emit(state.copyWith(isSubmitting: true,isFailure: false,isSuccess: false));
      await Future.delayed(Duration(seconds: 3));
      if(state.email==''||state.password==''){
        emit(state.copyWith(isSubmitting: false,isSuccess: true));
      }else{
        emit(state.copyWith(isSubmitting: false,isFailure: true));
      }
    });
  }
}

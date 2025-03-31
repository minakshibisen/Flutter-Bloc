import 'package:bloc_flutter/bloc/signUp/sign_up_event.dart';
import 'package:bloc_flutter/bloc/signUp/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupState.initial()) {
    on<NameChanged>((event, emit) {
      emit(state.copyWith(name: event.name));
    });

    on<EmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<ConfirmPasswordChanged>((event, emit) {
      emit(state.copyWith(confirmPassword: event.confirmPassword));
    });

    on<SignupSubmitted>((event, emit) async {
      if (state.password != state.confirmPassword) {
        emit(state.copyWith(isFailure: true, isSubmitting: false));
        return;
      }

      emit(state.copyWith(isSubmitting: true, isFailure: false));

      await Future.delayed(Duration(seconds: 2)); // Simulate API Call

      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    });
  }
}

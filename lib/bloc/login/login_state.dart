part of 'login_bloc.dart';

@immutable
class LoginState extends Equatable {
  final String email;
  final String password;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  const LoginState(
      {this.email = '',
      this.password = '',
      this.isSubmitting = false,
      this.isFailure = false,
      this.isSuccess = false});

  LoginState copyWith(
      {String? email,
      String? password,
      bool? isSubmitting,
      bool? isSuccess,
      bool? isFailure}) {
    return LoginState(
      email: email?? this.email,
      password: password?? this.password,
      isSubmitting: isSubmitting?? this.isSubmitting,
      isSuccess: isSuccess?? this.isSuccess,
      isFailure: isFailure?? this.isFailure,
    );

  }
  @override
  List<Object> get props=>[email,password,isSubmitting,isSuccess,isFailure];
}

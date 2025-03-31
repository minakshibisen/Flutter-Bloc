import 'package:equatable/equatable.dart';

class SignupState extends Equatable {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  const SignupState({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
  });

  factory SignupState.initial() {
    return SignupState(
      name:'',
      email: '',
      password: '',
      confirmPassword: '',
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  SignupState copyWith({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return SignupState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  List<Object> get props => [name,email, password, confirmPassword, isSubmitting, isSuccess, isFailure];
}

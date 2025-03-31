import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class NameChanged extends SignupEvent{
  final String name;
  NameChanged(this.name);
  @override
  List<Object>get props =>[name];
}

class EmailChanged extends SignupEvent {
  final String email;
  EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends SignupEvent {
  final String password;
  PasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class ConfirmPasswordChanged extends SignupEvent {
  final String confirmPassword;
  ConfirmPasswordChanged(this.confirmPassword);

  @override
  List<Object> get props => [confirmPassword];
}

class SignupSubmitted extends SignupEvent {}

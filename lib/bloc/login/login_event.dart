
import 'package:equatable/equatable.dart';

sealed class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmailChanged extends LoginEvent {
  final String email;

  EmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class PasswordChanged extends LoginEvent {
  final String password;

  PasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}
class LoginSubmitted extends LoginEvent{

}
class LoginApi extends LoginEvent{

}
class SignUp extends LoginEvent{

}

part of 'login_bloc.dart';

enum Status { signIn, signUp }

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class EmailUpdated extends LoginEvent {
  const EmailUpdated(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class PasswordUpdated extends LoginEvent {
  const PasswordUpdated(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class LoginStarted extends LoginEvent {
  final Status value;
  const LoginStarted({required this.value});
  @override
  List<Object> get props => [value];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

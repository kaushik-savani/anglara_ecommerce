part of 'signup_bloc.dart';

enum Status { signIn, signUp }

abstract class SignupEvent extends Equatable {
  const SignupEvent();
}

class NameUpdated extends SignupEvent {
  const NameUpdated(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}


class EmailUpdated extends SignupEvent {
  const EmailUpdated(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class PasswordUpdated extends SignupEvent {
  const PasswordUpdated(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class ConfirmPasswordUpdated extends SignupEvent {
  const ConfirmPasswordUpdated(this.confirmPassword);

  final String confirmPassword;

  @override
  List<Object> get props => [confirmPassword];
}

class SignUpStarted extends SignupEvent {
  final Status value;
  const SignUpStarted({required this.value});
  @override
  List<Object> get props => [value];
}

class SignUpSubmitted extends SignupEvent {
  const SignUpSubmitted();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

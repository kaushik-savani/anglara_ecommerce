part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class FormsValidate extends LoginState {
  const FormsValidate(
      {required this.email,
      required this.password,
      required this.isEmailValid,
      required this.isPasswordValid,
      this.errorMessage = '',
      required this.isFormValid,
      required this.isLoading,
      required this.isFormValidateFailed,
      this.isFormSuccessful = false});

  final String email;
  final String password;
  final String isEmailValid;
  final String isPasswordValid;
  final String errorMessage;
  final bool isFormValid;
  final bool isLoading;
  final bool isFormValidateFailed;
  final bool isFormSuccessful;

  FormsValidate copyWith({
    String? email,
    String? password,
    String? isEmailValid,
    String? isPasswordValid,
    String? errorMessage,
    bool? isFormValid,
    bool? isLoading,
    bool? isFormValidateFailed,
    bool? isFormSuccessful,
  }) {
    return FormsValidate(
        email: email ?? this.email,
        password: password ?? this.password,
        isEmailValid: isEmailValid ?? this.isEmailValid,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        errorMessage: errorMessage ?? this.errorMessage,
        isFormValid: isFormValid ?? this.isFormValid,
        isLoading: isLoading ?? this.isLoading,
        isFormValidateFailed: isFormValidateFailed ?? this.isFormValidateFailed,
        isFormSuccessful: isFormSuccessful ?? this.isFormSuccessful);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        email,
        password,
        isEmailValid,
        isPasswordValid,
        errorMessage,
        isFormValid,
        isLoading,
        isFormValidateFailed,
        isFormSuccessful
      ];
}

part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  const SignupState();
}

class SignupInitial extends SignupState {
  @override
  List<Object> get props => [];
}

class FormsValidate extends SignupState {
  const FormsValidate(
      {required this.name,required this.email,
        required this.password,
        required this.confirmPassword,
        required this.isNameValid,
        required this.isEmailValid,
        required this.isPasswordValid,
        required this.isConfirmPasswordValid,
        this.errorMessage = '',
        required this.isFormValid,
        required this.isLoading,
        required this.isFormValidateFailed,
        this.isFormSuccessful = false});

  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String isNameValid;
  final String isEmailValid;
  final String isPasswordValid;
  final String isConfirmPasswordValid;
  final String errorMessage;
  final bool isFormValid;
  final bool isLoading;
  final bool isFormValidateFailed;
  final bool isFormSuccessful;

  FormsValidate copyWith({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    String? isNameValid,
    String? isEmailValid,
    String? isPasswordValid,
    String? isConfirmPasswordValid,
    String? errorMessage,
    bool? isFormValid,
    bool? isLoading,
    bool? isFormValidateFailed,
    bool? isFormSuccessful,
  }) {
    return FormsValidate(
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        isNameValid: isNameValid ?? this.isNameValid,
        isEmailValid: isEmailValid ?? this.isEmailValid,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        isConfirmPasswordValid: isConfirmPasswordValid ?? this.isConfirmPasswordValid,
        errorMessage: errorMessage ?? this.errorMessage,
        isFormValid: isFormValid ?? this.isFormValid,
        isLoading: isLoading ?? this.isLoading,
        isFormValidateFailed: isFormValidateFailed ?? this.isFormValidateFailed,
        isFormSuccessful: isFormSuccessful ?? this.isFormSuccessful);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    name,
    email,
    password,
    confirmPassword,
    isNameValid,
    isEmailValid,
    isPasswordValid,
    isConfirmPasswordValid,
    errorMessage,
    isFormValid,
    isLoading,
    isFormValidateFailed,
    isFormSuccessful
  ];
}

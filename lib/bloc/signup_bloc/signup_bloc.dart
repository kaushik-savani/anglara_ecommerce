import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../constant/validator.dart';

part 'signup_event.dart';

part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, FormsValidate> {
  SignupBloc()
      : super(const FormsValidate(
          name: '',
          email: '',
          password: '',
          confirmPassword: '',
          isNameValid: '',
          isEmailValid: '',
          isPasswordValid: '',
          isConfirmPasswordValid: '',
          isFormValid: false,
          isLoading: false,
          isFormValidateFailed: false,
        )) {
    on<NameUpdated>(_NameUpdatedToState);
    on<EmailUpdated>(_EmailUpdatedToState);
    on<PasswordUpdated>(_PasswordUpdatedToState);
    on<ConfirmPasswordUpdated>(_ConfirmPasswordUpdatedToState);
    on<SignUpStarted>(_LoginStartedToState);
    on<SignUpSubmitted>(_LoginSubmittedToState);
  }

  _NameUpdatedToState(NameUpdated event, Emitter<FormsValidate> emit) {
    emit(state.copyWith(
      isFormSuccessful: false,
      isFormValid: false,
      isFormValidateFailed: false,
      errorMessage: "",
      name: event.name,
      isNameValid: Validator.validateName(event.name),
    ));
  }

  _EmailUpdatedToState(EmailUpdated event, Emitter<FormsValidate> emit) {
    emit(state.copyWith(
      isFormSuccessful: false,
      isFormValid: false,
      isFormValidateFailed: false,
      errorMessage: "",
      email: event.email,
      isEmailValid: Validator.validateEmail(event.email),
    ));
  }

  _PasswordUpdatedToState(PasswordUpdated event, Emitter<FormsValidate> emit) {
    emit(state.copyWith(
      isFormSuccessful: false,
      isFormValid: false,
      isFormValidateFailed: false,
      errorMessage: "",
      password: event.password,
      isPasswordValid: Validator.validatePassword(event.password),
    ));
  }

  _ConfirmPasswordUpdatedToState(
      ConfirmPasswordUpdated event, Emitter<FormsValidate> emit) {
    emit(state.copyWith(
      isFormSuccessful: false,
      isFormValid: false,
      isFormValidateFailed: false,
      errorMessage: "",
      confirmPassword: event.confirmPassword,
      isConfirmPasswordValid: Validator.validateConfirmPassword(
          event.confirmPassword, state.password),
    ));
  }

  _LoginStartedToState(SignUpStarted event, Emitter<FormsValidate> emit) async {
    emit(state.copyWith(
        errorMessage: '',
        isFormValid: Validator.validateName(state.name) == '' &&
            Validator.validateEmail(state.email) == '' &&
            Validator.validatePassword(state.password) == '' &&
            Validator.validatePassword(state.confirmPassword) == '',
        isLoading: true));
    await Future.delayed(const Duration(seconds: 2));
    if (event.value == Status.signUp) {
      await _authenticateUser(event, emit);
    }
  }

  _authenticateUser(SignUpStarted event, Emitter<FormsValidate> emit) async {
    if (state.isFormValid) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: state.email,
          password: state.password,
        );
        User? user = userCredential.user;
        await user!.updateDisplayName(state.name);
        emit(state.copyWith(isLoading: false, errorMessage: ""));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          emit(state.copyWith(
              isFormValid: false,
              errorMessage: "The password provided is too weak.",
              isLoading: false));
        } else if (e.code == 'email-already-in-use') {
          emit(state.copyWith(
              isFormValid: false,
              errorMessage: "The account already exists for that email.",
              isLoading: false));
        }
      } catch (e) {
        emit(state.copyWith(
            isFormValid: false, errorMessage: e.toString(), isLoading: false));
      }
    } else {
      emit(state.copyWith(
          isLoading: false, isFormValid: false, isFormValidateFailed: true));
    }
  }

  _LoginSubmittedToState(SignUpSubmitted event, Emitter<FormsValidate> emit) {
    emit(state.copyWith(isFormSuccessful: true));
  }
}

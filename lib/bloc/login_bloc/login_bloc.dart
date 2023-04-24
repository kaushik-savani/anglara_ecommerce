import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../constant/validator.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, FormsValidate> {
  LoginBloc()
      : super(const FormsValidate(
          email: '',
          password: '',
          isEmailValid: '',
          isPasswordValid: '',
          isFormValid: false,
          isLoading: false,
          isFormValidateFailed: false,
        )) {
    on<EmailUpdated>(_EmailUpdatedToState);
    on<PasswordUpdated>(_PasswordUpdatedToState);
    on<LoginStarted>(_LoginStartedToState);
    on<LoginSubmitted>(_LoginSubmittedToState);
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

  _LoginStartedToState(LoginStarted event, Emitter<FormsValidate> emit) async {
    print(Validator.validateEmail(state.email) == '');
    emit(state.copyWith(
        errorMessage: '',
        isFormValid: Validator.validateEmail(state.email) == '' &&
            Validator.validatePassword(state.password) == '',
        isLoading: true));
    await Future.delayed(const Duration(seconds: 2));
    if(event.value == Status.signIn){
      await _authenticateUser(event, emit);
    }
  }

  _authenticateUser(
      LoginStarted event, Emitter<FormsValidate> emit) async {
    if (state.isFormValid) {
      try {
        UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: state.email,
            password: state.password
        );
        emit(state.copyWith(isLoading: false, errorMessage: ""));
        debugPrint("$credential");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          emit(state.copyWith(isFormValid: false,errorMessage: "No user found for that email.",isLoading: false));
        } else if (e.code == 'wrong-password') {
          emit(state.copyWith(isFormValid: false,errorMessage: "Wrong password provided for that user.",isLoading: false));
        }
      }
    } else {
      emit(state.copyWith(
          isLoading: false, isFormValid: false, isFormValidateFailed: true));
    }
  }

  _LoginSubmittedToState(LoginSubmitted event, Emitter<FormsValidate> emit) {
    emit(state.copyWith(isFormSuccessful: true));
  }
}

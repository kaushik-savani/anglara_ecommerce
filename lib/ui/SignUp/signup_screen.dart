import 'package:anglara_ecommerce/bloc/signup_bloc/signup_bloc.dart';
import 'package:anglara_ecommerce/ui/SignUp/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Homepage/dashboard.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<SignupBloc>(
        create: (context) => SignupBloc(),
        child: BlocListener<SignupBloc, FormsValidate>(
          listener: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                ),
              );
            } else if (state.isFormValid && !state.isLoading) {
              context.read<SignupBloc>().add(const SignUpSubmitted());
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return const Dashboard();
              },));
            } else if (state.isFormValidateFailed) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Please fill the data correctly!')));
            }
          },
          child: const SignUpPage(),
        ),
      ),
    );
  }
}
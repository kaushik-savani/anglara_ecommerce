import 'package:anglara_ecommerce/ui/Login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/login_bloc/login_bloc.dart';
import '../Homepage/dashboard.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(),
        child: BlocListener<LoginBloc, FormsValidate>(
          listener: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                ),
              );
            } else if (state.isFormValid && !state.isLoading) {
              context.read<LoginBloc>().add(const LoginSubmitted());
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return const Dashboard();
              },));
            } else if (state.isFormValidateFailed) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Please fill the data correctly!')));
            }
          },
          child: const LoginPage(),
        ),
      ),
    );
  }
}
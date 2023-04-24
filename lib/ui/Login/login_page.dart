import 'package:anglara_ecommerce/ui/SignUp/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/login_bloc/login_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: 12, vertical: MediaQuery.of(context).size.height * .25),
        child: Column(
          children: [
            Text(
              "Sign In",
              style: TextStyle(
                  color: Colors.red.shade400,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            const EmailInput(),
            const SizedBox(height: 10),
            const PasswordInput(),
            const SizedBox(height: 30),
            const SubmitButton(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an Account?"),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const SignUpScreen();
                            },
                          ));
                    },
                    child: const Text("Sign Up",
                        style: TextStyle(color: Colors.black)))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, FormsValidate>(
      builder: (context, state) {
        return TextFormField(
          onChanged: (email) =>
              context.read<LoginBloc>().add(EmailUpdated(email)),
          keyboardType: TextInputType.emailAddress,
          decoration: state.isEmailValid.isEmpty
              ? InputDecoration(
                  hintText: "Enter Email",
                  prefixIcon: const Icon(
                    Icons.email,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)))
              : InputDecoration(
                  hintText: "Enter Email",
                  prefixIcon: const Icon(
                    Icons.email,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  errorText: state.isEmailValid),
        );
      },
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, FormsValidate>(
      builder: (context, state) {
        return TextFormField(
          onChanged: (password) =>
              context.read<LoginBloc>().add(PasswordUpdated(password)),
          obscureText: true,
          decoration: state.isPasswordValid.isEmpty
              ? InputDecoration(
                  hintText: "Enter Password",
                  prefixIcon: const Icon(
                    Icons.lock,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                )
              : InputDecoration(
                  hintText: "Enter Password",
                  prefixIcon: const Icon(
                    Icons.lock,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  errorText: state.isPasswordValid),
        );
        ;
      },
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, FormsValidate>(
      builder: (context, state) {
        return state.isLoading
            ? const CircularProgressIndicator()
            : InkWell(
                onTap: !state.isFormValid
                    ? () {
                        context
                            .read<LoginBloc>()
                            .add(const LoginStarted(value: Status.signIn));
                      }
                    : null,
                radius: 10,
                child: Container(
                  height: 46,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.center,
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 19),
                  ),
                ));
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/signup_bloc/signup_bloc.dart';


class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: 12, vertical: MediaQuery.of(context).size.height * .25),
        child: Column(
          children: [
            Text(
              "Sign Up",
              style: TextStyle(
                  color: Colors.red.shade400,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            const NameInput(),
            const SizedBox(height: 10),
            const EmailInput(),
            const SizedBox(height: 10),
            const PasswordInput(),
            const SizedBox(height: 10),
            const ConfirmPasswordInput(),
            const SizedBox(height: 30),
            const SubmitButton(),
          ],
        ),
      ),
    );
  }
}

class NameInput extends StatelessWidget {
  const NameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, FormsValidate>(
      builder: (context, state) {
        return TextFormField(
          onChanged: (name) =>
              context.read<SignupBloc>().add(NameUpdated(name)),
          keyboardType: TextInputType.name,
          decoration: state.isNameValid.isEmpty
              ? InputDecoration(
              hintText: "Enter Name",
              prefixIcon: const Icon(
                Icons.person,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8)))
              : InputDecoration(
              hintText: "Enter Name",
              prefixIcon: const Icon(
                Icons.person,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8)),
              errorText: state.isNameValid),
        );
      },
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, FormsValidate>(
      builder: (context, state) {
        return TextFormField(
          onChanged: (email) =>
              context.read<SignupBloc>().add(EmailUpdated(email)),
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
    return BlocBuilder<SignupBloc, FormsValidate>(
      builder: (context, state) {
        return TextFormField(
          onChanged: (password) =>
              context.read<SignupBloc>().add(PasswordUpdated(password)),
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

class ConfirmPasswordInput extends StatelessWidget {
  const ConfirmPasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, FormsValidate>(
      builder: (context, state) {
        return TextFormField(
          onChanged: (confirmPassword) =>
              context.read<SignupBloc>().add(ConfirmPasswordUpdated(confirmPassword)),
          obscureText: true,
          decoration: state.isConfirmPasswordValid.isEmpty
              ? InputDecoration(
            hintText: "Enter Confirm Password",
            prefixIcon: const Icon(
              Icons.lock,
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8)),
          )
              : InputDecoration(
              hintText: "Enter Confirm Password",
              prefixIcon: const Icon(
                Icons.lock,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8)),
              errorText: state.isConfirmPasswordValid),
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
    return BlocBuilder<SignupBloc, FormsValidate>(
      builder: (context, state) {
        return state.isLoading
            ? const CircularProgressIndicator()
            : InkWell(
            onTap: !state.isFormValid
                ? () {
              context
                  .read<SignupBloc>()
                  .add(const SignUpStarted(value: Status.signUp));
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
                'Sign Up',
                style: TextStyle(color: Colors.white, fontSize: 19),
              ),
            ));
      },
    );
  }
}

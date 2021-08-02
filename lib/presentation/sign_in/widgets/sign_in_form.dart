import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:sky_pet/application/auth/sign_in_form/cubit/sign_in_form_cubit.dart';
import 'package:sky_pet/presentation/components/already_have_an_account_check.dart';
import 'package:sky_pet/presentation/components/rounded_button.dart';
import 'package:sky_pet/presentation/components/rounded_input_field.dart';
import 'package:sky_pet/presentation/components/rounded_password_field.dart';
import 'package:sky_pet/presentation/routes/app_router.gr.dart';

class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Form(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'LOGIN',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Hero(
              tag: 'logo',
              child: SizedBox(
                height: size.width * 0.5,
                child: Image.asset(
                  'assets/images/logo.png',
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            _EmailInput(),
            _PasswordInput(),
            _SignInButton(),
            SizedBox(
              height: size.height * 0.04,
            ),
            AlreadyHaveAnAccountCheck(
              onTap: () => context.router.push(const SignUpRoute()),
            ),
          ],
        ),
      ),
    ));
    // return Scaffold(
    //   body: Center(
    //     child: SingleChildScrollView(
    //       child: Padding(
    //         padding: const EdgeInsets.symmetric(vertical: 24),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             const Text(
    //               'LOGIN',
    //               style: TextStyle(
    //                 fontWeight: FontWeight.bold,
    //               ),
    //             ),
    //             Hero(
    //               tag: 'logo',
    //               child: Container(
    //                 height: size.width * 0.5,
    //                 child: Image.asset(
    //                   'assets/images/logo.png',
    //                 ),
    //               ),
    //             ),
    //             SizedBox(
    //               height: size.height * 0.02,
    //             ),
    //             _EmailInput(),
    //             _PasswordInput(),
    //             _SignInButton(),
    //             SizedBox(
    //               height: size.height * 0.04,
    //             ),
    //             AlreadyHaveAnAccountCheck(
    //               onTap: () {
    //                 Navigator.pushNamed(context, SignUpScreen.routeId);
    //               },
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInFormCubit, SignInFormState>(
        buildWhen: (previous, current) =>
            previous.emailAddress != current.emailAddress,
        builder: (context, state) {
          return RoundedInputField(
            hintText: 'Tu e-mail',
            textInputType: TextInputType.emailAddress,
            //errorText: state.showErrorMessages ? 'e-mail no válido' : '',
            onChanged: (value) =>
                context.read<SignInFormCubit>().emailChanged(value),
          );
        });
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInFormCubit, SignInFormState>(
        buildWhen: (previous, current) => previous.password != current.password,
        builder: (context, state) {
          return RoundedPasswordField(
            errorText: state.showErrorMessages ? 'contraseña no válida' : '',
            onChanged: (value) =>
                context.read<SignInFormCubit>().passwordChanged(value),
          );
        });
  }
}

class _SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInFormCubit, SignInFormState>(
      builder: (context, state) {
        return state.isSubmitting
            ? const CircularProgressIndicator()
            : RoundedButton(
                title: 'LOGIN',
                onPressed: () =>
                    context.read<SignInFormCubit>().emailAndPassSignIn(),
              );
      },
    );
  }
}

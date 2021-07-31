import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:sky_pet/presentation/components/already_have_an_account_check.dart';
import 'package:sky_pet/presentation/components/rounded_input_field.dart';
import 'package:sky_pet/presentation/components/rounded_password_field.dart';
import 'package:sky_pet/presentation/login/cubit/sign_in_cubit.dart';
import 'package:sky_pet/presentation/routes/app_router.gr.dart';

class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: ListView(
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
    );
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
    return BlocBuilder<SignInCubit, SignInState>(
        buildWhen: (previous, current) => 1 != 0,
        /*previous.email != current.email,*/
        builder: (context, state) {
          return RoundedInputField(
            hintText: 'Tu e-mail',
            textInputType: TextInputType.emailAddress,
            errorText: /*state.email.invalid ?*/ 'e-mail no válido',
            onChanged: (value) =>
                context.read<SignInCubit>().emailChanged(value),
          );
        });
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
        buildWhen: (previous, current) => 1 != 0,
        /*previous.password != current.password,*/
        builder: (context, state) {
          return RoundedPasswordField(
            errorText: 'contraseña no válida',
            onChanged: (value) =>
                context.read<SignInCubit>().passwordChanged(value),
          );
        });
  }
}

class _SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return const CircularProgressIndicator();
        // return state.status.isSubmissionInProgress
        //     ? const CircularProgressIndicator()
        //     : RoundedButton(title: 'LOGIN', onPressed: () {}
        //         // state.status.isValidated
        //         //     ? () => context.read<SignInCubit>().signInWithCredentials()
        //         //     : {},
        //         );
      },
    );
  }
}

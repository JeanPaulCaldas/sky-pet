import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_pet/application/auth/sign_up_form/cubit/sign_up_form_cubit.dart';
import 'package:sky_pet/presentation/components/already_have_an_account_check.dart';
import 'package:sky_pet/presentation/components/rounded_button.dart';
import 'package:sky_pet/presentation/components/rounded_input_field.dart';
import 'package:sky_pet/presentation/components/rounded_password_field.dart';
import 'package:auto_route/auto_route.dart';
import 'package:sky_pet/presentation/routes/app_router.gr.dart';
import 'package:sky_pet/presentation/sign_up/components/social_icon.dart';

import 'or_divider.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  Future<void> _showMyDialog(BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Failed Sign Up!'),
          content: SingleChildScrollView(
            child: Text(message),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {},
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocConsumer<SignUpFormCubit, SignUpFormState>(
        listener: (context, state) {
      state.authFailureOrSuccessOption.fold(
        () {},
        (either) => either.fold((authF) {
          _showMyDialog(
              context,
              authF.map(
                cancelledByUser: (_) => 'Cancelado',
                serverError: (_) => 'Error del servidor',
                invalidCredentials: (_) => 'Credenciales no válidas',
                emailAlreadyInUse: (_) => 'Ya esxiste una cuenta con el email',
                connectionError: (_) => 'Error de conexión a la red',
              ));
        }, (_) => context.router.push(const HomeRoute())),
      );
    }, builder: (context, state) {
      return Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'SIGN UP',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: size.width * 0.4,
                  child: Image.asset('assets/images/logo.png'),
                ),
                RoundedInputField(
                  hintText: 'Your Email',
                  onChanged: (value) =>
                      context.read<SignUpFormCubit>().emailChanged(value),
                  onValidate: (_) => context
                      .read<SignUpFormCubit>()
                      .state
                      .emailAddress
                      .value
                      .fold(
                          (l) => l.maybeMap(
                              invalidEmail: (_) => 'E-mail no válido',
                              orElse: () => null),
                          (r) => null),
                ),
                RoundedPasswordField(
                  onChanged: (value) =>
                      context.read<SignUpFormCubit>().passwordChanged(value),
                  onValidate: (_) => context
                      .read<SignUpFormCubit>()
                      .state
                      .password
                      .value
                      .fold(
                          (l) => l.maybeMap(
                              noMatchingPasswordConfirmation: (_) =>
                                  'No coinciden las contraseñas',
                              shortPassword: (_) =>
                                  'Contraseña menor a 6 caracteres',
                              orElse: () => null),
                          (r) => null),
                ),
                RoundedButton(
                  title: 'SIGN UP',
                  onPressed: () =>
                      context.read<SignUpFormCubit>().emailAndPassSignUp(),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                AlreadyHaveAnAccountCheck(
                  login: false,
                  onTap: () => context.router.push(const SignInRoute()),
                ),
                const OrDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialIcon(
                      iconPath: 'assets/icons/facebook.svg',
                      onTap: () {},
                    ),
                    SocialIcon(
                      iconPath: 'assets/icons/google-plus.svg',
                      onTap: () =>
                          context.read<SignUpFormCubit>().googleSignIn(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

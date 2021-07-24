import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_pet/injection_container.dart';
import 'package:sky_pet/presentation/login/login_screen.dart';

import 'cubit/sign_in_cubit.dart';

class LoginPage extends StatelessWidget {
  static String routeId = 'login';
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: BlocProvider(
          create: (_) => sl<SignInCubit>(),
          child: LoginScreen(),
        ),
      ),
    );
  }
}

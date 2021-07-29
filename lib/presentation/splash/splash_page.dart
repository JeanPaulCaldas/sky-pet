import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_pet/application/auth/auth_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:sky_pet/presentation/routes/app_router.gr.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.map(
          initial: (_) {},
          authenticated: (_) {},
          unauthenticated: (_) => context.router.pushNamed(WelcomeScreen.name),
        );
      },
      child: const Center(
        child: Text('Validando...'),
      ),
    );
  }
}

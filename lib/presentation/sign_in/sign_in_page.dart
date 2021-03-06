import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_pet/application/auth/sign_in_form/cubit/sign_in_form_cubit.dart';
import 'package:sky_pet/injection.dart';
import 'package:sky_pet/presentation/sign_in/widgets/sign_in_form.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => getIt<SignInFormCubit>(),
        child: SignInForm(),
      ),
    );
  }
}

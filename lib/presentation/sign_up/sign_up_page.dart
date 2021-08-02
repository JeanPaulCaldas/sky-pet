import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_pet/application/auth/sign_up_form/cubit/sign_up_form_cubit.dart';
import 'package:sky_pet/injection.dart';
import 'package:sky_pet/presentation/sign_up/components/sign_up_form.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => getIt<SignUpFormCubit>(),
        child: const SignUpForm(),
      ),
    );
  }
}

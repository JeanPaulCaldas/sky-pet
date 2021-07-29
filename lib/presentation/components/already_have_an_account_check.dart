import 'package:flutter/material.dart';

import '../core/constants.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function? onTap;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          login ? 'No tienes una cuenta ? ' : 'Ya tienes una cuenta ? ',
          style: const TextStyle(color: kPrimaryColor),
        ),
        GestureDetector(
          onTap: onTap as void Function()?,
          child: Text(
            login ? 'Sign Up' : 'Sign In',
            style: const TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}

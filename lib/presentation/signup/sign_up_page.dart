import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:sky_pet/presentation/components/already_have_an_account_check.dart';
import 'package:sky_pet/presentation/components/rounded_button.dart';
import 'package:sky_pet/presentation/components/rounded_input_field.dart';
import 'package:sky_pet/presentation/components/rounded_password_field.dart';
import 'package:sky_pet/presentation/routes/app_router.gr.dart';

import 'components/or_divider.dart';
import 'components/social_icon.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
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
                  onChanged: (value) {},
                ),
                RoundedPasswordField(
                  onChanged: (value) {},
                ),
                RoundedButton(
                  title: 'SIGN UP',
                  onPressed: () {},
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
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

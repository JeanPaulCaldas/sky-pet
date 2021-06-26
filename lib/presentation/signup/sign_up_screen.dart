import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sky_pet/presentation/components/already_have_an_account_check.dart';
import 'package:sky_pet/presentation/components/rounded_button.dart';
import 'package:sky_pet/presentation/components/rounded_input_field.dart';
import 'package:sky_pet/presentation/components/rounded_password_field.dart';
import 'package:sky_pet/presentation/login/login_screen.dart';

import 'components/or_divider.dart';
import 'components/social_icon.dart';

class SignUpScreen extends StatefulWidget {
  static String routeId = 'registration';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              children: [
                Text(
                  'SIGN UP',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  child: Image.asset('assets/images/logo.png'),
                  height: size.width * 0.4,
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
                  onTap: () {
                    Navigator.pushNamed(context, LoginScreen.routeId);
                  },
                ),
                OrDivider(),
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

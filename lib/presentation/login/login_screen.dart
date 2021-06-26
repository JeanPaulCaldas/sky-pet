import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sky_pet/presentation/components/already_have_an_account_check.dart';
import 'package:sky_pet/presentation/components/rounded_button.dart';
import 'package:sky_pet/presentation/components/rounded_input_field.dart';
import 'package:sky_pet/presentation/components/rounded_password_field.dart';
import 'package:sky_pet/presentation/signup/sign_up_screen.dart';

class LoginScreen extends StatelessWidget {
  static String routeId = 'login';

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;

    Size size = MediaQuery.of(context).size;
    bool showModal = false;
    String email;
    String password;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'LOGIN',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: size.width * 0.5,
                    child: Image.asset(
                      'assets/images/logo.png',
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                RoundedInputField(
                  hintText: 'Your Email',
                  onChanged: (value) {},
                ),
                RoundedPasswordField(
                  onChanged: (value) {},
                ),
                RoundedButton(
                    title: 'LOGIN',
                    onPressed: () async {
                      try {} catch (e) {}
                    }),
                SizedBox(
                  height: size.height * 0.04,
                ),
                AlreadyHaveAnAccountCheck(
                  onTap: () {
                    Navigator.pushNamed(context, SignUpScreen.routeId);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sky_pet/presentation/components/rounded_button.dart';
import 'package:sky_pet/presentation/core/constants.dart';
import 'package:sky_pet/presentation/sign_in/sign_in_page.dart';
import 'package:sky_pet/presentation/signup/sign_up_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static String routeId = 'welcome';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('assets/images/logo.png'),
                    height: size.width * 0.3,
                  ),
                ),
                Text(
                  'SKY-PET',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText('SIEMPRE CONTIGO',
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        speed: const Duration(milliseconds: 250),
                        textAlign: TextAlign.start),
                  ],
                  totalRepeatCount: 4,
                  pause: const Duration(milliseconds: 500),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'LOG IN',
              onPressed: () => Navigator.pushNamed(context, SignInPage.routeId),
            ),
            RoundedButton(
              title: 'SIGN UP',
              color: kPrimaryLightColor,
              textColor: Colors.black,
              onPressed: () =>
                  Navigator.pushNamed(context, SignUpScreen.routeId),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sky_pet/presentation/components/rounded_button.dart';
import 'package:sky_pet/presentation/core/constants.dart';
import 'package:sky_pet/presentation/routes/app_router.gr.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: size.width * 0.3,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
                const Text(
                  'SKY-PET',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText(
                      'SIEMPRE CONTIGO',
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      speed: const Duration(milliseconds: 250),
                    ),
                  ],
                  totalRepeatCount: 4,
                  pause: const Duration(milliseconds: 500),
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'SIGN IN',
              onPressed: () => context.router.push(const SignInRoute()),
            ),
            RoundedButton(
              title: 'SIGN UP',
              color: kPrimaryLightColor,
              textColor: Colors.black,
              onPressed: () => context.router.push(const SignUpRoute()),
            )
          ],
        ),
      ),
    );
  }
}

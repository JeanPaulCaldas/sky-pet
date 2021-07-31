import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/widgets.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
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
    );
  }
}

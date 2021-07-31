import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sky_pet/presentation/core/constants.dart';

class RoundedButton extends StatelessWidget {
  final String? title;
  final Color color, textColor;
  final Function onPressed;

  const RoundedButton(
      {this.title,
      this.color = kPrimaryColor,
      this.textColor = Colors.white,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.8,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(29.0),
        child: MaterialButton(
          onPressed: onPressed as void Function()?,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title!,
            style: TextStyle(color: textColor, fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}

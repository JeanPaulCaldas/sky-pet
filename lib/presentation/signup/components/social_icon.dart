import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants.dart';

class SocialIcon extends StatelessWidget {
  final String iconPath;
  final Function onTap;
  const SocialIcon({
    Key key,
    this.iconPath,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: kPrimaryLightColor,
          ),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          iconPath,
          color: kPrimaryColor,
          height: 20,
          width: 20,
        ),
      ),
    );
  }
}

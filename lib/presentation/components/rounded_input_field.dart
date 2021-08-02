import 'package:flutter/material.dart';
import 'package:sky_pet/presentation/components/text_field_container.dart';

import '../core/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String? hintText;
  final IconData icon;
  final TextInputType? textInputType;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? onValidate;

  const RoundedInputField({
    Key? key,
    this.hintText,
    this.icon = Icons.person,
    this.textInputType,
    this.onChanged,
    this.onValidate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        onChanged: onChanged,
        validator: onValidate,
        keyboardType: textInputType,
        decoration: InputDecoration(
          hintText: hintText,
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

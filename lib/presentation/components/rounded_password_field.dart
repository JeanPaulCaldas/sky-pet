import 'package:flutter/material.dart';
import 'package:sky_pet/presentation/components/text_field_container.dart';

import '../core/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? onValidate;

  const RoundedPasswordField({
    Key? key,
    this.errorText,
    this.onChanged,
    this.onValidate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        obscureText: true,
        onChanged: onChanged,
        validator: onValidate,
        decoration: InputDecoration(
            hintText: 'Contraseña',
            icon: const Icon(
              Icons.lock,
              color: kPrimaryColor,
            ),
            suffixIcon: const Icon(
              Icons.visibility,
              color: kPrimaryColor,
            ),
            border: InputBorder.none,
            errorText: errorText),
      ),
    );
  }
}

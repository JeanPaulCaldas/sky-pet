import 'package:dartz/dartz.dart';
import 'package:sky_pet/domain/core/failures.dart';

Either<ValueFailure<String>, String> validateEmail(String input) {
  final RegExp _emailRegExp = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');

  return _emailRegExp.hasMatch(input)
      ? right(input)
      : left(ValueFailure.invalidEmail(failedValue: input));
}

Either<ValueFailure<String>, String> validatePassword(String input) {
  final _passwordRegExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  return _passwordRegExp.hasMatch(input)
      ? right(input)
      : left(ValueFailure.shortPassword(failedValue: input));
}

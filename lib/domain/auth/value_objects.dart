import 'package:sky_pet/domain/core/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:sky_pet/domain/core/value_objects.dart';
import 'package:sky_pet/domain/core/value_validators.dart';

class EmailAddress extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory EmailAddress(String input) {
    return EmailAddress._(validateEmail(input));
  }

  const EmailAddress._(this.value);
}

class Password extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory Password(String input) {
    return Password._(validatePassword(input));
  }

  const Password._(this.value);
}

class PasswordConfirmation extends ValueObject<String> {
  @override
  // TODO: implement value
  final Either<ValueFailure<String>, String> value;

  factory PasswordConfirmation(String input, String password) {
    return PasswordConfirmation._(
      input == password
          ? right(input)
          : left(
              ValueFailure.noMatchingPasswordConfirmation(failedValue: input)),
    );
  }

  const PasswordConfirmation._(this.value);
}

import 'package:dartz/dartz.dart';
import 'package:sky_pet/domain/auth/auth_failure.dart';
import 'package:sky_pet/domain/auth/i_auth_repository.dart';
import 'package:sky_pet/domain/auth/value_objects.dart';

class CredentialSignIn {
  final AuthRepository _repository;

  CredentialSignIn({required AuthRepository repository})
      : _repository = repository;

  Future<Either<AuthFailure, Unit>> call(
          EmailAddress email, Password password) async =>
      _repository.signInWithEmailAndPass(email: email, password: password);
}

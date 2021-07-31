import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sky_pet/domain/auth/auth_failure.dart';
import 'package:sky_pet/domain/auth/i_auth_repository.dart';
import 'package:sky_pet/domain/auth/value_objects.dart';

@lazySingleton
@injectable
class CredentialSignUp {
  final AuthRepository _repository;

  CredentialSignUp({required AuthRepository repository})
      : _repository = repository;

  Future<Either<AuthFailure, Unit>> call(
          {required EmailAddress email, required Password password}) async =>
      _repository.signUpWithEmailAndPass(email: email, password: password);
}

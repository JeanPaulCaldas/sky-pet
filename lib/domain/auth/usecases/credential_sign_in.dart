import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sky_pet/domain/auth/auth_failure.dart';
import 'package:sky_pet/domain/auth/i_auth_repository.dart';
import 'package:sky_pet/domain/auth/value_objects.dart';

@lazySingleton
@injectable
class CredentialSignIn {
  final AuthRepository _repository;

  CredentialSignIn({required AuthRepository repository})
      : _repository = repository;

  Future<Either<AuthFailure, Unit>> call(
          {required EmailAddress email, required Password password}) async =>
      _repository.signInWithEmailAndPass(email: email, password: password);
}

import 'package:dartz/dartz.dart';
import 'package:sky_pet/core/failures.dart';
import 'package:sky_pet/domain/repositories/auth_repository.dart';

class CredentialSignUp {
  final AuthRepository repository;

  CredentialSignUp(this.repository);

  Future<Either<Failure, void>> call(String email, String password) async =>
      await repository.credentialSignUp(email, password);
}
import 'package:dartz/dartz.dart';
import 'package:sky_pet/domain/auth/auth_failure.dart';
import 'package:sky_pet/domain/auth/i_auth_repository.dart';

class GoogleSignIn {
  final AuthRepository _repository;

  GoogleSignIn({required AuthRepository repository}) : _repository = repository;

  Future<Either<AuthFailure, Unit>> call() async => _repository.googleSignIn();
}

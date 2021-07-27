import 'package:dartz/dartz.dart';
import 'package:sky_pet/core/failures.dart';
import 'package:sky_pet/domain/repositories/auth_repository.dart';

class FacebookSignIn {
  final AuthRepository repository;

  FacebookSignIn({required this.repository});

  Future<Either<Failure, void>> call() async =>
      await repository.facebookSignIn();
}

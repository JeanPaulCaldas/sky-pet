import 'package:dartz/dartz.dart';
import 'package:sky_pet/core/failures.dart';
import 'package:sky_pet/domain/repositories/auth_repository.dart';

class EmailSignIn {
  final AuthRepository repository;

  EmailSignIn(this.repository);

  Future<Either<Failure, bool>> call(String email, String password) async {
    return await repository.emailSignIn(email, password);
  }
}

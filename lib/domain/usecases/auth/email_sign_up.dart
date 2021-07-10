import 'package:dartz/dartz.dart';
import 'package:sky_pet/core/failures.dart';
import 'package:sky_pet/domain/repositories/auth_repository.dart';

class EmailSignUp {
  final AuthRepository repository;

  EmailSignUp(this.repository);

  Future<Either<Failure, bool>> call(String email, String password) async {
    return await repository.emailSignUp(email, password);
  }
}

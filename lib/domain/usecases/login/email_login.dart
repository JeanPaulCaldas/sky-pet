import 'package:dartz/dartz.dart';
import 'package:sky_pet/core/failures.dart';
import 'package:sky_pet/domain/models/user.dart';
import 'package:sky_pet/domain/repositories/login_repository.dart';

class EmailLogin {
  final LoginRepository repository;

  EmailLogin(this.repository);

  Future<Either<Failure, User>> call(String email, String password) async {
    return await repository.emailLogin(email, password);
  }
}

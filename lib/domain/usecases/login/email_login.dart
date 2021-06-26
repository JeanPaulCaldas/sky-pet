import 'package:dartz/dartz.dart';
import 'package:sky_pet/core/failure.dart';
import 'package:sky_pet/domain/models/user.dart';
import 'package:sky_pet/domain/repository/login_repository.dart';
import 'package:meta/meta.dart';

class EmailLogin {
  final LoginRepository repository;

  EmailLogin(this.repository);

  Future<Either<Failure, User>> execute(String email, String password) async {
    return await repository.emailLogin(email, password);
  }
}

import 'package:dartz/dartz.dart';
import 'package:sky_pet/core/failure.dart';
import 'package:sky_pet/domain/models/user.dart';
import 'package:sky_pet/domain/repositories/login_repository.dart';

class FacebookLogin {
  final LoginRepository repository;

  FacebookLogin(this.repository);

  Future<Either<Failure, User>> call() async {
    return await repository.facebookLogin();
  }
}

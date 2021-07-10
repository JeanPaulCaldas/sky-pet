import 'package:dartz/dartz.dart';
import 'package:sky_pet/core/failures.dart';
import 'package:sky_pet/domain/models/user.dart';
import 'package:sky_pet/domain/repositories/auth_repository.dart';

class FacebookLogin {
  final AuthRepository repository;

  FacebookLogin(this.repository);

  Future<Either<Failure, User>> call() async {
    return await repository.socialAuthFacebook();
  }
}

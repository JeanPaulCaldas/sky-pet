import 'package:dartz/dartz.dart';
import 'package:sky_pet/core/failures.dart';
import 'package:sky_pet/domain/models/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> emailSignUp(String email, String password);
  Future<Either<Failure, bool>> emailSignIn(String email, String password);
  Future<Either<Failure, User>> socialAuthFacebook();
  Future<Either<Failure, User>> socialAuthGoogle();
}

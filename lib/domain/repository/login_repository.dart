import 'package:dartz/dartz.dart';
import 'package:sky_pet/core/failure.dart';
import 'package:sky_pet/domain/models/user.dart';

abstract class LoginRepository {
  Future<Either<Failure, User>> emailLogin(String email, String password);
  Future<Either<Failure, User>> facebookLogin();
  Future<Either<Failure, User>> googleLogin();
}

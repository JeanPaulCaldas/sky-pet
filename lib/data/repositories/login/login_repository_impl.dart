import 'package:sky_pet/domain/models/user.dart';
import 'package:sky_pet/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:sky_pet/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  @override
  Future<Either<Failure, User>> emailLogin(String email, String password) {
    // TODO: implement emailLogin
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> facebookLogin() {
    // TODO: implement facebookLogin
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> googleLogin() {
    // TODO: implement googleLogin
    throw UnimplementedError();
  }
}

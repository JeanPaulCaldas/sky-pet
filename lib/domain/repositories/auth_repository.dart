import 'package:dartz/dartz.dart';
import 'package:sky_pet/core/failures.dart';
import 'package:sky_pet/domain/models/user_model.dart';

abstract class AuthRepository {
  Stream<UserModel> get user;

  Future<Either<Failure, void>> credentialSignUp(String email, String password);

  Future<Either<Failure, void>> credentialSignIn(String email, String password);

  Future<Either<Failure, UserModel>> get currentUser;

  Future<Either<Failure, void>> googleSignIn();

  Future<Either<Failure, void>> facebookSignIn();

  Future<Either<Failure, void>> signOut();
}

import 'package:dartz/dartz.dart';
import 'package:sky_pet/domain/auth/auth_failure.dart';
import 'package:sky_pet/domain/auth/user.dart';
import 'package:sky_pet/domain/auth/value_objects.dart';

abstract class AuthRepository {
  Stream<Option<User>> get user;

  Future<Either<AuthFailure, Unit>> signUpWithEmailAndPass(
      {required EmailAddress email, required Password password});

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPass(
      {required EmailAddress email, required Password password});

  //Future<Either<AuthFailure, User>> get currentUser;

  Future<Either<AuthFailure, Unit>> googleSignIn();

  //Future<Either<AuthFailure, Unit>> facebookSignIn();

  Future<void> signOut();
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sky_pet/core/network_info.dart';
import 'package:sky_pet/data/datasources/auth_firebase_data_source.dart';
import 'package:sky_pet/core/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:sky_pet/domain/auth/auth_failure.dart';
import 'package:sky_pet/domain/auth/i_auth_repository.dart';
import 'package:sky_pet/domain/auth/value_objects.dart';
import 'package:sky_pet/domain/auth/user.dart' as d;

typedef Chooser = Future<void> Function();

class AuthRepositoryImpl implements AuthRepository {
  final AuthFirebaseDataSource _firebaseDataSource;
  final NetworkInfo _networkInfo;

  AuthRepositoryImpl({
    required AuthFirebaseDataSource firebaseDataSource,
    required NetworkInfo networkInfo,
  })  : _firebaseDataSource = firebaseDataSource,
        _networkInfo = networkInfo;

  Future<Either<Failure, void>> _callDataSourceMethod(Chooser method) async {
    if (!await _networkInfo.isConnected) return Left(NetworkFailure());
    try {
      return Right(await method());
    } on FirebaseAuthException {
      return Left(FirebaseFailure());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> googleSignIn() {
    // TODO: implement googleSignIn
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPass(
      {required EmailAddress email, required Password password}) {
    // TODO: implement signInWithEmailAndPass
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, Unit>> signUpWithEmailAndPass(
      {required EmailAddress email, required Password password}) {
    // TODO: implement signUpWithEmailAndPass
    throw UnimplementedError();
  }

  @override
  // TODO: implement user
  Stream<Option<d.User>> get user => throw UnimplementedError();

  // @override
  // Future<Either<Failure, void>> signUpWithEmailAndPass(
  //     String email, String password) async {
  //   return _callDataSourceMethod(
  //       () => firebaseDataSource.credentialsSignUp(email, password));
  // }

  // @override
  // Future<Either<Failure, void>> signInWithEmailAndPass(
  //     String email, String password) async {
  //   return _callDataSourceMethod(
  //       () => firebaseDataSource.credentialsSignIn(email, password));
  // }

  // @override
  // Future<Either<Failure, UserModel>> get currentUser async {
  //   try {
  //     return Right(await firebaseDataSource.currentUser);
  //   } catch (e) {
  //     return Left(FirebaseFailure());
  //   }
  // }

  // @override
  // Future<Either<Failure, void>> facebookSignIn() {
  //   // TODO: implement facebookLogin
  //   throw UnimplementedError();
  // }

  // @override
  // Future<Either<Failure, void>> googleSignIn() {
  //   // TODO: implement googleLogin
  //   throw UnimplementedError();
  // }

  // @override
  // Stream<UserModel> get user => firebaseDataSource.user;

  // @override
  // Future<Either<Failure, void>> signOut() {
  //   // TODO: implement signOut
  //   throw UnimplementedError();
  // }
}

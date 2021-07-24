import 'package:firebase_auth/firebase_auth.dart';
import 'package:sky_pet/core/exceptions.dart';
import 'package:sky_pet/core/network_info.dart';
import 'package:sky_pet/data/datasources/auth_firebase_data_source.dart';
import 'package:sky_pet/domain/models/user_model.dart';
import 'package:sky_pet/core/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:sky_pet/domain/repositories/auth_repository.dart';

typedef Future<void> _Chooser();

class AuthRepositoryImpl implements AuthRepository {
  final AuthFirebaseDataSource firebaseDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({this.firebaseDataSource, this.networkInfo});

  Future<Either<Failure, void>> _callDataSourceMethod(_Chooser method) async {
    if (!await networkInfo.isConnected) return Left(NetworkFailure());
    try {
      return Right(await method());
    } on FirebaseAuthException {
      return Left(FirebaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> credentialSignUp(
      String email, String password) async {
    return _callDataSourceMethod(
        () => firebaseDataSource.credentialsSignUp(email, password));
  }

  @override
  Future<Either<Failure, void>> credentialSignIn(
      String email, String password) async {
    return _callDataSourceMethod(
        () => firebaseDataSource.credentialsSignIn(email, password));
  }

  @override
  Future<Either<Failure, UserModel>> get currentUser async {
    try {
      return Right(await firebaseDataSource.currentUser);
    } catch (e) {
      return Left(FirebaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> facebookSignIn() {
    // TODO: implement facebookLogin
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> googleSignIn() {
    // TODO: implement googleLogin
    throw UnimplementedError();
  }

  @override
  Stream<UserModel> get user => firebaseDataSource.user;

  @override
  Future<Either<Failure, void>> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}

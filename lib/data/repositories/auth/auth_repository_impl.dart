import 'package:sky_pet/core/exceptions.dart';
import 'package:sky_pet/core/network_info.dart';
import 'package:sky_pet/data/datasources/auth_remote_data_source.dart';
import 'package:sky_pet/domain/models/user.dart';
import 'package:sky_pet/core/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:sky_pet/domain/repositories/auth_repository.dart';

typedef Future<bool> _Chooser();

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({this.remoteDataSource, this.networkInfo});

  Future<Either<Failure, void>> _callDataSourceMethod(_Chooser method) async {
    if (!await networkInfo.isConnected) return Left(NetworkFailure());
    try {
      return Right(await method());
    } on FirebaseException {
      return Left(FirebaseFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> credentialSignUp(
      String email, String password) async {
    return _callDataSourceMethod(
        () => remoteDataSource.emailSignUp(email, password));
  }

  @override
  Future<Either<Failure, bool>> credentialSignIn(
      String email, String password) async {
    return _callDataSourceMethod(
        () => remoteDataSource.emailSignIn(email, password));
  }

  @override
  Future<Either<Failure, User>> facebookSignIn() {
    // TODO: implement facebookLogin
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> googleSignIn() {
    // TODO: implement googleLogin
    throw UnimplementedError();
  }

  @override
  Stream<User> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}

import 'package:sky_pet/core/exceptions.dart';
import 'package:sky_pet/core/network_info.dart';
import 'package:sky_pet/data/datasources/login_local_data_source.dart';
import 'package:sky_pet/data/datasources/login_remote_data_source.dart';
import 'package:sky_pet/domain/models/user.dart';
import 'package:sky_pet/core/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:sky_pet/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;
  final LoginLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  LoginRepositoryImpl(
      {this.remoteDataSource, this.localDataSource, this.networkInfo});

  @override
  Future<Either<Failure, User>> emailLogin(
      String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.emailLogin(email, password));
      } on FirebaseException {
        return Left(FirebaseFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
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

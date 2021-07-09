import 'package:dartz/dartz.dart';
import 'package:sky_pet/core/failures.dart';
import 'package:sky_pet/data/models/user_model.dart';

abstract class LoginRemoteDataSource {
  Future<UserModel> emailLogin(String email, String password);
}

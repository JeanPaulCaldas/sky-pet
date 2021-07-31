import 'package:dartz/dartz.dart';
import 'package:sky_pet/domain/auth/user.dart';
import 'package:sky_pet/domain/auth/i_auth_repository.dart';

class GetAuthUser {
  final AuthRepository _repository;

  GetAuthUser({required AuthRepository repository}) : _repository = repository;

  Stream<Option<User>> call() => _repository.user;
}

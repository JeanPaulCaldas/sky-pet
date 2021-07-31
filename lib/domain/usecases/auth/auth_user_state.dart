import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sky_pet/domain/auth/user.dart';
import 'package:sky_pet/domain/auth/i_auth_repository.dart';

@lazySingleton
@injectable
class AuthUserState {
  final AuthRepository _repository;

  AuthUserState({required AuthRepository repository})
      : _repository = repository;

  Stream<Option<User>> call() => _repository.userState;
}

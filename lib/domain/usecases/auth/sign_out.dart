import 'package:sky_pet/domain/auth/i_auth_repository.dart';

class SignOut {
  final AuthRepository _repository;

  SignOut({required AuthRepository repository}) : _repository = repository;

  Future<void> call() async => _repository.signOut();
}

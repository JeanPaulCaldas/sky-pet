import 'package:sky_pet/domain/models/user_model.dart';
import 'package:sky_pet/domain/repositories/auth_repository.dart';

class GetUserStream {
  final AuthRepository repository;

  GetUserStream({required this.repository});

  Stream<UserModel> call() => repository.user;
}

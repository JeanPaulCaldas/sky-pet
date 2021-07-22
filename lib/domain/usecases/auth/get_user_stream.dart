import 'package:sky_pet/domain/models/user.dart';
import 'package:sky_pet/domain/repositories/auth_repository.dart';

class GetUserStream {
  final AuthRepository repository;

  GetUserStream(this.repository);

  Stream<User> call() => repository.getUser();
}

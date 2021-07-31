import 'package:sky_pet/domain/auth/i_auth_repository.dart';

class GetCurrentUser {
  final AuthRepository repository;

  GetCurrentUser({required this.repository});

  // Future<Either<Failure, UserModel>> call() async => repository.currentUser;
}

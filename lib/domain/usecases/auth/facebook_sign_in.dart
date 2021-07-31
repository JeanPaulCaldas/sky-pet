import 'package:sky_pet/domain/auth/i_auth_repository.dart';

class FacebookSignIn {
  final AuthRepository repository;

  FacebookSignIn({required this.repository});

  // Future<Either<Failure, void>> call() async =>
  //     await repository.facebookSignIn();
}

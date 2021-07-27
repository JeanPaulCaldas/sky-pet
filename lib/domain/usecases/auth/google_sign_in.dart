import 'package:dartz/dartz.dart';
import 'package:sky_pet/core/failures.dart';
import 'package:sky_pet/domain/repositories/auth_repository.dart';

class GoogleSignIn {
  final AuthRepository repository;

  GoogleSignIn({required this.repository});

  Future<Either<Failure, void>> call() async => await repository.googleSignIn();
}

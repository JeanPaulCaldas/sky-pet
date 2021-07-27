import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sky_pet/domain/models/user_model.dart';
import 'package:sky_pet/domain/usecases/auth/get_current_user.dart';

import 'mock_login_repository.dart';

void main() {
  late GetCurrentUser usecase;
  MockAuthRepository? repository;
  setUp(() {
    repository = MockAuthRepository();
    usecase = GetCurrentUser(repository);
  });

  test('should get current user when is available', () async {
    //arrange
    when(repository!.currentUser)
        .thenAnswer((_) async => Right(UserModel.empty));
    //act
    final Either<Failure, UserModel>? result = await usecase();
    //assert
    expect(result, Right(UserModel.empty));
    verify(repository!.currentUser).called(1);
  });
}

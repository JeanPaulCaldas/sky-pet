import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sky_pet/domain/usecases/auth/facebook_sign_in.dart';

import 'mock_login_repository.dart';

void main() {
  FacebookSignIn usecase;
  MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = FacebookSignIn(mockAuthRepository);
  });

  test('should sign in with facebook', () async {
    //arrange
    when(mockAuthRepository.facebookSignIn())
        .thenAnswer((_) async => Right(Null));

    //act
    final result = await usecase();

    //assert
    expect(result, Right(Null));
    verify(mockAuthRepository.facebookSignIn());
    verifyNoMoreInteractions(mockAuthRepository);
  });
}

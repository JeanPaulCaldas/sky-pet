import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sky_pet/domain/usecases/auth/credential_sign_up.dart';

import 'mock_login_repository.dart';

void main() {
  CredentialSignUp useCase;
  MockAuthRepository mockAuthRepository;

  final tEmail = 'email@mail.com';
  final tPass = 'securepass123*';

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = CredentialSignUp(mockAuthRepository);
  });

  test('should sign up with valid credentials', () async {
    //arrange
    when(mockAuthRepository.credentialSignUp(any, any))
        .thenAnswer((_) async => Right(Null));
    //act
    final result = await useCase.call(tEmail, tPass);
    //assert
    verify(mockAuthRepository.credentialSignUp(tEmail, tPass));
    verifyNoMoreInteractions(mockAuthRepository);
    expect(result, Right(Null));
  });
}

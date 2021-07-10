import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sky_pet/domain/usecases/auth/email_sign_up.dart';

import 'mock_login_repository.dart';

void main() {
  EmailSignUp useCase;
  MockAuthRepository mockAuthRepository;

  final tEmail = 'email@mail.com';
  final tPass = 'securepass123*';

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = EmailSignUp(mockAuthRepository);
  });

  test('should sign up when valid credentials are provided', () async {
    //arrange
    when(mockAuthRepository.emailSignUp(any, any))
        .thenAnswer((_) async => Right(true));
    //act
    final result = await useCase.call(tEmail, tPass);
    //assert
    verify(mockAuthRepository.emailSignUp(tEmail, tPass));
    verifyNoMoreInteractions(mockAuthRepository);
    expect(result, Right(true));
  });
}

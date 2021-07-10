import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sky_pet/domain/models/user.dart';
import 'package:sky_pet/domain/usecases/auth/email_sign_in.dart';

import 'mock_login_repository.dart';

void main() {
  EmailSignIn usecase;
  MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = EmailSignIn(mockAuthRepository);
  });

  final tUser = User(id: 'a897da8', name: 'test name');

  test('should login with email', () async {
    //arrange
    when(mockAuthRepository.emailSignIn(any, any))
        .thenAnswer((_) async => Right(true));

    //act
    final result = await usecase(tUser.id, tUser.name);

    //assert
    expect(result, Right(true));
    verify(mockAuthRepository.emailSignIn(tUser.id, tUser.name));
    verifyNoMoreInteractions(mockAuthRepository);
  });
}

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sky_pet/domain/models/user.dart';
import 'package:sky_pet/domain/usecases/login/email_login.dart';

import 'mock_login_repository.dart';

void main() {
  EmailLogin usecase;
  MockLoginRepository mockLoginRepository;

  setUp(() {
    mockLoginRepository = MockLoginRepository();
    usecase = EmailLogin(mockLoginRepository);
  });

  final tUser = User(id: 'a897da8', name: 'test name');

  test('should login with email', () async {
    //arrange
    when(mockLoginRepository.emailLogin(any, any))
        .thenAnswer((_) async => Right(tUser));

    //act
    final result = await usecase(tUser.id, tUser.name);

    //assert
    expect(result, Right(tUser));
    verify(mockLoginRepository.emailLogin(tUser.id, tUser.name));
    verifyNoMoreInteractions(mockLoginRepository);
  });
}

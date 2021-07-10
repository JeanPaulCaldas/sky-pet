import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sky_pet/domain/models/user.dart';
import 'package:sky_pet/domain/usecases/auth/facebook_login.dart';

import 'mock_login_repository.dart';

void main() {
  FacebookLogin usecase;
  MockAuthRepository mockLoginRepository;

  setUp(() {
    mockLoginRepository = MockAuthRepository();
    usecase = FacebookLogin(mockLoginRepository);
  });

  final tUser = User(id: 'a897da8', name: 'test name');

  test('should login with facebook', () async {
    //arrange
    when(mockLoginRepository.socialAuthFacebook())
        .thenAnswer((_) async => Right(tUser));

    //act
    final result = await usecase();

    //assert
    expect(result, Right(tUser));
    verify(mockLoginRepository.socialAuthFacebook());
    verifyNoMoreInteractions(mockLoginRepository);
  });
}

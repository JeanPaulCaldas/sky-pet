import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sky_pet/domain/models/user.dart';
import 'package:sky_pet/domain/usecases/login/facebook_login.dart';

import 'mock_login_repository.dart';

void main() {
  FacebookLogin usecase;
  MockLoginRepository mockLoginRepository;

  setUp(() {
    mockLoginRepository = MockLoginRepository();
    usecase = FacebookLogin(mockLoginRepository);
  });

  final tUser = User(id: 'a897da8', name: 'test name');

  test('should login with facebook', () async {
    //arrange
    when(mockLoginRepository.facebookLogin())
        .thenAnswer((_) async => Right(tUser));

    //act
    final result = await usecase();

    //assert
    expect(result, Right(tUser));
    verify(mockLoginRepository.facebookLogin());
    verifyNoMoreInteractions(mockLoginRepository);
  });
}

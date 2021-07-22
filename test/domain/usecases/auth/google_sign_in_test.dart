import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sky_pet/domain/usecases/auth/google_sign_in.dart';

import 'mock_login_repository.dart';

void main() {
  GoogleSignIn usecase;
  MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = GoogleSignIn(mockAuthRepository);
  });

  test('should sign in with google', () async {
    //arrange
    when(mockAuthRepository.googleSignIn())
        .thenAnswer((_) async => Right(Null));
    //act
    final result = await usecase();
    //assert
    expect(result, Right(Null));
    verify(mockAuthRepository.googleSignIn());
    verifyNoMoreInteractions(mockAuthRepository);
  });
}

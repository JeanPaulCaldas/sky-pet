import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sky_pet/domain/usecases/auth/sign_out.dart';

import 'mock_login_repository.dart';

void main() {
  MockAuthRepository mockRepository;
  SignOut usecase;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = SignOut(mockRepository);
  });

  test('should sign out', () async {
    //arrange
    when(mockRepository.signOut()).thenAnswer((_) async => Right(Null));
    //act
    final result = await usecase();
    //assert
    expect(result, Right(Null));
    verify(mockRepository.signOut()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}

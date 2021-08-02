import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sky_pet/domain/auth/usecases/google_sign_in.dart';
import 'package:sky_pet/domain/auth/i_auth_repository.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late GoogleSignIn usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = GoogleSignIn(repository: mockAuthRepository);
  });

  test('should sign in with google', () async {
    //arrange
    when(() => mockAuthRepository.googleSignIn())
        .thenAnswer((_) async => Right(unit));
    //act
    final result = await usecase();
    //assert
    expect(result, Right(unit));
    verify(() => mockAuthRepository.googleSignIn());
    verifyNoMoreInteractions(mockAuthRepository);
  });
}

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sky_pet/domain/usecases/auth/credential_sign_in.dart';
import 'package:sky_pet/domain/auth/i_auth_repository.dart';
import 'package:sky_pet/domain/auth/value_objects.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late CredentialSignIn usecase;
  late MockAuthRepository mockAuthRepository;

  final tEmail = EmailAddress('mail@mail.com');
  final tPass = Password('securePass');

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = CredentialSignIn(repository: mockAuthRepository);
  });

  test('should sign in with credentials', () async {
    //arrange
    when(() => mockAuthRepository.signInWithEmailAndPass(
        email: any(), password: any())).thenAnswer((_) async => Right(unit));

    //act
    final result = await usecase(tEmail, tPass);

    //assert
    expect(result, Right(unit));
    verify(() => mockAuthRepository.signInWithEmailAndPass(
        email: tEmail, password: tPass));
    verifyNoMoreInteractions(mockAuthRepository);
  });
}

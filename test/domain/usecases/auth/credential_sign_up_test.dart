import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sky_pet/domain/auth/usecases/credential_sign_up.dart';
import 'package:sky_pet/domain/auth/i_auth_repository.dart';
import 'package:sky_pet/domain/auth/value_objects.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late CredentialSignUp useCase;
  late MockAuthRepository mockAuthRepository;

  final tEmail = EmailAddress('mail@mail.com');
  final tPass = Password('securePass');

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = CredentialSignUp(repository: mockAuthRepository);
  });

  test('should sign up with valid credentials', () async {
    //arrange
    when(() => mockAuthRepository.signUpWithEmailAndPass(
          email: any(),
          password: any(),
        )).thenAnswer((_) async => Right(unit));
    //act
    final result = await useCase(email: tEmail, password: tPass);
    //assert
    verify(() => mockAuthRepository.signUpWithEmailAndPass(
        email: tEmail, password: tPass));
    verifyNoMoreInteractions(mockAuthRepository);
    expect(result, Right(unit));
  });
}

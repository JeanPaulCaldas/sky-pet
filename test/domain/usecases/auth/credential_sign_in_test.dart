import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sky_pet/domain/usecases/auth/credential_sign_in.dart';

import 'mock_login_repository.dart';

void main() {
  late CredentialSignIn usecase;
  late MockAuthRepository mockAuthRepository;

  final tEmail = 'mail@mail.com';
  final tPass = 'securePass';

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = CredentialSignIn(repository: mockAuthRepository);
  });

  test('should sign in with credentials', () async {
    //arrange
    when(mockAuthRepository!.credentialSignIn(any!, any!))
        .thenAnswer((_) async => Right(Null));

    //act
    final Either<Failure, void>? result = await usecase(tEmail, tPass);

    //assert
    expect(result, Right(Null));
    verify(mockAuthRepository!.credentialSignIn(tEmail, tPass));
    verifyNoMoreInteractions(mockAuthRepository);
  });
}

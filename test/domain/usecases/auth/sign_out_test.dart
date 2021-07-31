import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sky_pet/domain/usecases/auth/sign_out.dart';
import 'package:sky_pet/domain/auth/i_auth_repository.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late SignOut usecase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = SignOut(repository: mockRepository);
  });

  test('should sign out', () async {
    //arrange
    when(() => mockRepository.signOut()).thenAnswer((_) async => Right(null));
    //act
    await usecase();
    //assert
    verify(() => mockRepository.signOut()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}

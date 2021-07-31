import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sky_pet/domain/auth/i_auth_repository.dart';
import 'package:sky_pet/domain/auth/user.dart';
import 'package:sky_pet/domain/core/value_objects.dart';
import 'package:sky_pet/domain/usecases/auth/auth_user_state.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthUserState usecase;
  late MockAuthRepository mockRepository;

  final tUser = User(id: UniqueId());

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = AuthUserState(repository: mockRepository);
  });

  test('should emit User Stream with user empty', () {
    //arrange
    when(() => mockRepository.userState)
        .thenAnswer((_) => Stream.value(some(tUser)));
    //act - assert
    expectLater(usecase(), emits(tUser));
    verify(() => mockRepository.userState).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}

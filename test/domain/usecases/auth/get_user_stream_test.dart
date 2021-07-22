import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sky_pet/domain/models/user.dart';
import 'package:sky_pet/domain/usecases/auth/get_user_stream.dart';

import 'mock_login_repository.dart';

void main() {
  GetUserStream usecase;
  MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = GetUserStream(mockRepository);
  });

  test('should emit User Stream with user empty', () {
    //arrange
    when(mockRepository.getUser()).thenAnswer((_) => Stream.value(User.empty));
    //act - assert
    expectLater(usecase(), emits(User.empty));
    verify(mockRepository.getUser()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}

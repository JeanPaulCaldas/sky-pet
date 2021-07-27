import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sky_pet/domain/models/user_model.dart';
import 'package:sky_pet/domain/usecases/auth/get_user_stream.dart';

import 'mock_login_repository.dart';

void main() {
  late GetUserStream usecase;
  MockAuthRepository? mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = GetUserStream(mockRepository);
  });

  test('should emit User Stream with user empty', () {
    //arrange
    when(mockRepository!.user).thenAnswer((_) => Stream.value(UserModel.empty));
    //act - assert
    expectLater(usecase(), emits(UserModel.empty));
    verify(mockRepository!.user).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}

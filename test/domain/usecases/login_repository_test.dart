import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sky_pet/domain/models/user.dart';
import 'package:sky_pet/domain/repository/login_repository.dart';
import 'package:sky_pet/domain/usecases/login/email_login.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  EmailLogin usecase;
  MockLoginRepository mockRepository;

  setUp(() {
    mockRepository = MockLoginRepository();
    usecase = EmailLogin(mockRepository);
  });

  final tUser = User(id: 'a897da8', name: 'test name');

  test('should login with email', () async {
    //arrange
    when(mockRepository.emailLogin('', ''))
        .thenAnswer((_) async => Right(tUser));

    //act
    final result = await usecase.execute('', '');

    //assert
    expect(result, Right(tUser));
    verify(mockRepository.emailLogin('email', 'password'));
  });
}

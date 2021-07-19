import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sky_pet/core/failures.dart';
import 'package:sky_pet/domain/usecases/auth/email_sign_in.dart';
import 'package:sky_pet/domain/usecases/auth/email_sign_up.dart';
import 'package:sky_pet/presentation/login/bloc/auth_login_bloc.dart';

class MockEmailSignIn extends Mock implements EmailSignIn {}

class MockEmailSignUp extends Mock implements EmailSignUp {}

main() {
  AuthLoginBloc bloc;
  MockEmailSignIn mockEmailSignIn;
  MockEmailSignUp mockEmailSignUp;

  setUp(() {
    mockEmailSignIn = MockEmailSignIn();
    mockEmailSignUp = MockEmailSignUp();
    bloc = AuthLoginBloc(
        emailSignIn: mockEmailSignIn, emailSignUp: mockEmailSignUp);
  });

  test('initial state should be empty', () {
    expect(bloc.state, equals(Empty()));
  });

  group('Auth Sign In', () {
    final String tEmail = 'mail@mail.com';
    final String tPass = 'securePass';

    test('should emit [Error] state when invalid credentials', () async {
      //arrange
      when(mockEmailSignIn.call(any, any))
          .thenAnswer((_) async => Left(FirebaseFailure()));
      
      //assert
      expectLater(bloc.state,
          emitsInOrder([Empty(), Error(message: FIREBASE_FAILURE_MESSAGE)]));

      //act
      bloc.add(AuthSignIn(email: tEmail, password: tPass));
    });
  });
}

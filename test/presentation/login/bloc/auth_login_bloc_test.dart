import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sky_pet/core/failures.dart';
import 'package:sky_pet/domain/usecases/auth/credential_sign_in.dart';
import 'package:sky_pet/domain/usecases/auth/credential_sign_up.dart';
import 'package:sky_pet/presentation/login/bloc/auth_login_bloc.dart';
import 'package:bloc_test/bloc_test.dart';

class MockEmailSignIn extends Mock implements CredentialSignIn {}

class MockEmailSignUp extends Mock implements CredentialSignUp {}

main() {
  AuthLoginBloc bloc;
  MockEmailSignIn mockEmailSignIn;
  MockEmailSignUp mockEmailSignUp;

  final String tEmail = 'mail@mail.com';
  final String tPass = 'securePass';

  setUp(() {
    mockEmailSignIn = MockEmailSignIn();
    mockEmailSignUp = MockEmailSignUp();
    bloc = AuthLoginBloc(
        emailSignIn: mockEmailSignIn, emailSignUp: mockEmailSignUp);
  });

  test('initial state should be empty', () {
    expect(bloc.state, equals(Empty()));
  });

  group('Auth Sign In Failure', () {
    setUp(() {
      when(mockEmailSignIn(any, any))
          .thenAnswer((_) async => Left(FirebaseFailure()));
    });

    blocTest(
      'should emit [Error] state with propper message when firebase failure',
      build: () => bloc,
      act: (bloc) => bloc.add(AuthSignIn(email: tEmail, password: tPass)),
      skip: 1,
      expect: () => [Error(message: FIREBASE_FAILURE_MESSAGE)],
    );

    blocTest<AuthLoginBloc, AuthLoginState>(
      'should emits [Error] state with propper message when network failure',
      build: () {
        when(mockEmailSignIn(any, any))
            .thenAnswer((_) async => Left(NetworkFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(AuthSignIn(email: tEmail, password: tPass)),
      skip: 1,
      expect: () => [Error(message: NETWORK_FAILURE_MESSAGE)],
    );

    blocTest<AuthLoginBloc, AuthLoginState>(
      'should emits [Error] when AuthSignIn is added.',
      build: () => bloc,
      act: (bloc) => bloc.add(AuthSignIn(email: tEmail, password: tPass)),
      skip: 1,
      expect: () => [isA<Error>()],
    );

    blocTest<AuthLoginBloc, AuthLoginState>(
      'should emits [Loading, Error] when AuthSignIn is added.',
      build: () => bloc,
      act: (bloc) => bloc.add(AuthSignIn(email: tEmail, password: tPass)),
      expect: () => [isA<Loading>(), isA<Error>()],
    );
  });

  group('Auth Sign In', () {
    setUp(() {
      when(mockEmailSignIn(any, any)).thenAnswer((_) async => Right(true));
    });

    blocTest<AuthLoginBloc, AuthLoginState>(
        'should emits [Loaded] when AuthSignIn is added.',
        build: () => bloc,
        act: (bloc) => bloc.add(AuthSignIn(email: tEmail, password: tPass)),
        skip: 1,
        expect: () => [isA<Loaded>()],
        verify: (_) => verify(mockEmailSignIn(tEmail, tPass)));

    blocTest('should emits [Loading, Loaded] when successful',
        build: () => bloc,
        act: (bloc) => bloc.add(AuthSignIn(email: tEmail, password: tPass)),
        expect: () => [isA<Loading>(), isA<Loaded>()]);
  });
}

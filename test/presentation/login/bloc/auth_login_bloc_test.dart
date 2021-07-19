import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sky_pet/core/failures.dart';
import 'package:sky_pet/domain/usecases/auth/email_sign_in.dart';
import 'package:sky_pet/domain/usecases/auth/email_sign_up.dart';
import 'package:sky_pet/presentation/login/bloc/auth_login_bloc.dart';
import 'package:bloc_test/bloc_test.dart';

class MockEmailSignIn extends Mock implements EmailSignIn {}

class MockEmailSignUp extends Mock implements EmailSignUp {}

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

  group('Auth Sign In FirebaseFailure', () {
    setUp(() {
      when(mockEmailSignIn(any, any))
          .thenAnswer((_) async => Left(FirebaseFailure()));
    });

    blocTest(
      'should emit [Error] state when invalid credentials',
      build: () => bloc,
      act: (bloc) => bloc.add(AuthSignIn(email: tEmail, password: tPass)),
      skip: 1,
      expect: () => [Error(message: FIREBASE_FAILURE_MESSAGE)],
    );

    blocTest<AuthLoginBloc, AuthLoginState>(
      'should emits [Error] when AuthSignIn is added.',
      build: () => bloc,
      act: (bloc) => bloc.add(AuthSignIn(email: tEmail, password: tPass)),
      skip: 1,
      expect: () => [isA<Error>()],
    );
  });

  group('Auth Sign In', () {
    setUp(() {
      when(mockEmailSignIn(any, any)).thenAnswer((_) async => Right(true));
    });

    blocTest<AuthLoginBloc, AuthLoginState>(
        'emits [Loaded] when AuthSignIn is added.',
        build: () => bloc,
        act: (bloc) => bloc.add(AuthSignIn(email: tEmail, password: tPass)),
        skip: 1,
        expect: () => [isA<Loaded>()],
        verify: (_) => verify(mockEmailSignIn(tEmail, tPass)));

    blocTest('should emits [Loading, Loaded] when successful',
        build: () => bloc,
        act: (bloc) => bloc.add(AuthSignIn(email: tEmail, password: tPass)),
        expect: () => [Loading(), Loaded(loged: true)]);
  });
}

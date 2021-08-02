// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
// import 'package:sky_pet/domain/auth/auth_failure.dart';
// import 'package:sky_pet/domain/auth/value_objects.dart';
import 'package:sky_pet/domain/auth/usecases/credential_sign_in.dart';
import 'package:sky_pet/domain/auth/usecases/credential_sign_up.dart';
//import 'package:bloc_test/bloc_test.dart';

class MockEmailSignIn extends Mock implements CredentialSignIn {}

class MockEmailSignUp extends Mock implements CredentialSignUp {}

main() {
  // late AuthLoginBloc bloc;
  // late MockEmailSignIn mockEmailSignIn;
  // MockEmailSignUp mockEmailSignUp;

  // final String tEmail = 'mail@mail.com';
  // final String tPass = 'securePass';

  // setUp(() {
  //   mockEmailSignIn = MockEmailSignIn();
  //   mockEmailSignUp = MockEmailSignUp();
  //   bloc = AuthLoginBloc(
  //       credentialSignIn: mockEmailSignIn, credentialSignUp: mockEmailSignUp);
  // });

  // test('initial state should be empty', () {
  //   expect(bloc.state, equals(Empty()));
  // });

  // group('Auth Sign In Failure', () {
  //   setUp(() {
  //     when(() => mockEmailSignIn(any(), any()))
  //         .thenAnswer((_) async => Left(AuthFailure.invalidCredentials()));
  //   });

  //   blocTest(
  //     'should emit [Error] state with propper message when firebase failure',
  //     build: () => bloc,
  //     act: (dynamic bloc) =>
  //         bloc.add(AuthSignIn(email: tEmail, password: tPass)),
  //     skip: 1,
  //     expect: () => [Error(message: FIREBASE_FAILURE_MESSAGE)],
  //   );

  //   blocTest<AuthLoginBloc, AuthLoginState>(
  //     'should emits [Error] state with propper message when network failure',
  //     build: () {
  //       when(() => mockEmailSignIn(any(), any()))
  //           .thenAnswer((_) async => Left(AuthFailure.connectionError()));
  //       return bloc;
  //     },
  //     act: (bloc) => bloc.add(AuthSignIn(email: tEmail, password: tPass)),
  //     skip: 1,
  //     expect: () => [Error(message: NETWORK_FAILURE_MESSAGE)],
  //   );

  //   blocTest<AuthLoginBloc, AuthLoginState>(
  //     'should emits [Error] when AuthSignIn is added.',
  //     build: () => bloc,
  //     act: (bloc) => bloc.add(AuthSignIn(email: tEmail, password: tPass)),
  //     skip: 1,
  //     expect: () => [isA<Error>()],
  //   );

  //   blocTest<AuthLoginBloc, AuthLoginState>(
  //     'should emits [Loading, Error] when AuthSignIn is added.',
  //     build: () => bloc,
  //     act: (bloc) => bloc.add(AuthSignIn(email: tEmail, password: tPass)),
  //     expect: () => [isA<Loading>(), isA<Error>()],
  //   );
  // });

  // group('Auth Sign In', () {
  //   setUp(() {
  //     when(() => mockEmailSignIn(any(), any()))
  //         .thenAnswer((_) async => Right(unit));
  //   });

  //   final email = EmailAddress(tEmail);
  //   final pass = Password(tPass);

  //   blocTest<AuthLoginBloc, AuthLoginState>(
  //       'should emits [Loaded] when AuthSignIn is added.',
  //       build: () => bloc,
  //       act: (bloc) => bloc.add(AuthSignIn(email: tEmail, password: tPass)),
  //       skip: 1,
  //       expect: () => [isA<Loaded>()],
  //       verify: (_) => verify(() => mockEmailSignIn(email, pass)));

  //   blocTest('should emits [Loading, Loaded] when successful',
  //       build: () => bloc,
  //       act: (dynamic bloc) =>
  //           bloc.add(AuthSignIn(email: tEmail, password: tPass)),
  //       expect: () => [isA<Loading>(), isA<Loaded>()]);
  // });
}

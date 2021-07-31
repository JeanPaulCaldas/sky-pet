import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sky_pet/domain/auth/auth_failure.dart';
import 'package:sky_pet/domain/usecases/auth/credential_sign_up.dart';
import 'package:sky_pet/domain/usecases/auth/google_sign_in.dart';
import 'package:sky_pet/application/auth/sign_up_form/cubit/sign_up_form_cubit.dart';

class MockCredentialSignUp extends Mock implements CredentialSignUp {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

void main() {
  late SignUpFormCubit cubit;
  late MockCredentialSignUp mockSignUp;
  late MockGoogleSignIn mockGSignIn;

  setUp(() {
    mockSignUp = MockCredentialSignUp();
    mockGSignIn = MockGoogleSignIn();
    cubit = SignUpFormCubit(mockSignUp, mockGSignIn);
  });

  test('Initial state should be empty', () {
    expect(cubit.state, equals(SignUpFormState.initial()));
  });

  group('Google sign up failed', () {
    late SignUpFormState tState;

    setUp(() {
      when(() => mockGSignIn.call())
          .thenAnswer((_) async => Left(AuthFailure.serverError()));

      tState = SignUpFormState.initial().copyWith(
          authFailureOrSuccessOption: some(Left(AuthFailure.serverError())));
    });

    blocTest<SignUpFormCubit, SignUpFormState>(
      'should emit server error failure option when firebase auth fails.',
      build: () => cubit,
      act: (cubit) => cubit.googleSignIn(),
      skip: 1,
      expect: () => tState,
    );

    // blocTest<SignUpFormCubit, SignUpFormState>(
    //   'should emits [MyState] when email and pass sign up is called.',
    //   build: () => cubit,
    //   act: (cubit) => cubit.emailAndPassSignUp(),
    //   expect: () => const <SignUpFormState>[MyState],
    // );
  });
}

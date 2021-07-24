import 'dart:async';
//import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sky_pet/core/failures.dart';
import 'package:sky_pet/domain/usecases/auth/credential_sign_in.dart';
import 'package:sky_pet/domain/usecases/auth/credential_sign_up.dart';

part 'auth_login_event.dart';
part 'auth_login_state.dart';

const String FIREBASE_FAILURE_MESSAGE = 'Firebase failure';
const String NETWORK_FAILURE_MESSAGE = 'Network failure';

class AuthLoginBloc extends Bloc<AuthLoginEvent, AuthLoginState> {
  final CredentialSignIn credentialSignIn;
  final CredentialSignUp credentialSignUp;

  AuthLoginBloc({
    this.credentialSignIn,
    this.credentialSignUp,
  })  : assert(credentialSignIn != null),
        assert(credentialSignUp != null),
        super(Empty());

  @override
  Stream<AuthLoginState> mapEventToState(
    AuthLoginEvent event,
  ) async* {
    if (event is AuthSignIn) {
      yield Loading();
      final authEither = await credentialSignIn(event.email, event.password);
      yield* _eitherLoadedOrErrorState(authEither);
    }
  }

  Stream<AuthLoginState> _eitherLoadedOrErrorState(
    Either<Failure, void> authEither,
  ) async* {
    yield authEither.fold(
      (failure) => Error(message: _mapFailureToMessage[failure.runtimeType]),
      (r) => Loaded(),
    );
  }

  final Map<Type, String> _mapFailureToMessage = {
    FirebaseFailure: FIREBASE_FAILURE_MESSAGE,
    NetworkFailure: NETWORK_FAILURE_MESSAGE
  };
}

import 'dart:async';
//import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sky_pet/domain/usecases/auth/email_sign_in.dart';
import 'package:sky_pet/domain/usecases/auth/email_sign_up.dart';

part 'auth_login_event.dart';
part 'auth_login_state.dart';

const String FIREBASE_FAILURE_MESSAGE = 'Firebase failure';

class AuthLoginBloc extends Bloc<AuthLoginEvent, AuthLoginState> {
  final EmailSignIn emailSignIn;
  final EmailSignUp emailSignUp;

  AuthLoginBloc({
    this.emailSignIn,
    this.emailSignUp,
  })  : assert(emailSignIn != null),
        assert(emailSignUp != null),
        super(Empty());

  //AuthLoginBloc() : super(Empty());

  @override
  Stream<AuthLoginState> mapEventToState(
    AuthLoginEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is AuthSignIn) {
      final authEither = await emailSignIn.call(event.email, event.password);
      yield* authEither.fold((l) async* {
        yield Error(message: FIREBASE_FAILURE_MESSAGE);
      }, (r) => throw UnimplementedError());
    }
  }
}

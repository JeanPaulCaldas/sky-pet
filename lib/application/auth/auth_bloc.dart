import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sky_pet/domain/auth/user.dart';
import 'package:sky_pet/domain/usecases/auth/auth_user_state.dart';
import 'package:sky_pet/domain/usecases/auth/sign_out.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUserState _authUserState;
  final SignOut _signOut;
  late final StreamSubscription<Option<User>> _subscription;

  AuthBloc({
    required AuthUserState authUserState,
    required SignOut signOut,
  })  : _authUserState = authUserState,
        _signOut = signOut,
        super(const _Initial()) {
    _subscription = _authUserState().listen(_onUserChanged);
  }

  void _onUserChanged(Option<User> option) => add(_UserStateChanged(option));

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    yield* event.map(signOutRequested: (e) async* {
      await _signOut();
      yield const _Unauthenticated();
    }, userStateChanged: (e) async* {
      yield _mapUserChangedToState(e);
    });
  }

  AuthState _mapUserChangedToState(_UserStateChanged event) {
    return event.optionUser.fold(
      () => const _Unauthenticated(),
      (user) => _Authenticated(user),
    );
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}

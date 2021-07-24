import 'dart:async';
//import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sky_pet/domain/models/user_model.dart';
import 'package:sky_pet/domain/usecases/auth/get_current_user.dart';
import 'package:sky_pet/domain/usecases/auth/get_user_stream.dart';
import 'package:sky_pet/domain/usecases/auth/sign_out.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final GetUserStream getUser;
  final GetCurrentUser getCurrentUser;
  final SignOut signOut;
  StreamSubscription<UserModel> _subscription;

  AppBloc({this.getUser, this.getCurrentUser, this.signOut})
      : super(const AppState.unauthenticated()) {
    _subscription = getUser.call().listen(_onUserChanged);
  }
  void _onUserChanged(UserModel user) => add(AppUserChanged(user));

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    if (event is AppUserChanged) {
      yield _mapUserChangeToState(event, state);
    } else if (event is AppLogoutRequested) {
      await signOut();
    }
  }

  AppState _mapUserChangeToState(AppUserChanged event, AppState state) {
    return !event.user.isEmpty
        ? AppState.authenticated(event.user)
        : AppState.unauthenticated();
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}

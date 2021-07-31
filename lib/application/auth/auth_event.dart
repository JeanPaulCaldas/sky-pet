part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.userStateChanged(Option<User> optionUser) =
      _UserStateChanged;
  const factory AuthEvent.signOutRequested() = _SignOutRequested;
}

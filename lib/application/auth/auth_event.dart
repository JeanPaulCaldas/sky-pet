part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.userAuthStateRequested() = _UserAuthStateRequested;
  const factory AuthEvent.signOutRequested() = _SignOutRequested;
}

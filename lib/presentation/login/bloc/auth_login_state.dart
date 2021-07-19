part of 'auth_login_bloc.dart';

abstract class AuthLoginState extends Equatable {
  const AuthLoginState();

  @override
  List<Object> get props => [];
}

class Empty extends AuthLoginState {}

class Loading extends AuthLoginState {}

class Loaded extends AuthLoginState {
  final bool loged;

  Loaded({this.loged});

  @override
  List<Object> get props => [loged];
}

class Error extends AuthLoginState {
  final String message;

  Error({this.message});

  @override
  List<Object> get props => [message];
}

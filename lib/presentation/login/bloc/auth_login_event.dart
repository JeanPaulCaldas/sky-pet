part of 'auth_login_bloc.dart';

abstract class AuthLoginEvent extends Equatable {
  const AuthLoginEvent();

  @override
  List<Object> get props => [];
}

class AuthSignIn extends AuthLoginEvent {
  final String email;
  final String password;

  AuthSignIn({this.email, this.password});

  @override
  List<Object> get props => [email, password];
}

class AuthSignUp extends AuthLoginEvent {
  final String email;
  final String password;

  AuthSignUp(this.email, this.password);
}

class AuthWithFacebook extends AuthLoginEvent{}

class AuthWithGoogle extends AuthLoginEvent{}
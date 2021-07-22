import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class FirebaseFailure extends Failure {}

class NetworkFailure extends Failure {}

class SignUpFailure extends Failure {}

class SignInWithCredentialsFailure extends Failure {}

class SignInWithGoogleFailure extends Failure {}

class SignOutFailure extends Failure {}

part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  const SignInState._({
    //this.email = const Email.pure(),
    //this.password = const Password.pure(),
    this.status = FormzStatus.pure,
  });

  //final Email email;
  //final Password password;
  final FormzStatus status;

  @override
  List<Object> get props => [status];

  SignInState copyWith({
    // Email email,
    // Password password,
    FormzStatus? status,
  }) =>
      SignInState._(
          // email: email ?? this.email,
          // password: password ?? this.password,
          status: status ?? this.status);
}

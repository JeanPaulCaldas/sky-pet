part of 'sign_in_form_bloc.dart';

@freezed
class SignInFormEvent with _$SignInFormEvent {
  const factory SignInFormEvent.emailChanged(String email) = EmailChanged;
  const factory SignInFormEvent.passwordChanged(String password) =
      PasswordChanged;
  const factory SignInFormEvent.signInWithCredentials() = SignInWithCredentials;
  const factory SignInFormEvent.signUpWithCredentials() = SignUpWithCredentials;
  const factory SignInFormEvent.signInWithGoogle() = SignInWithGoogle;
}

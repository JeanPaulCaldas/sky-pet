part of 'sign_up_form_cubit.dart';

@freezed
abstract class SignUpFormState with _$SignUpFormState {
  const factory SignUpFormState({
    required EmailAddress emailAddress,
    required Password password,
    required PasswordConfirmation passwordConfirmation,
    required bool showErrorMessages,
    required bool isSubmitting,
    required Option<Either<AuthFailure, Unit>> authFailureOrSuccessOption,
  }) = _SignUpFormState;

  factory SignUpFormState.initial() => SignUpFormState(
        emailAddress: EmailAddress(''),
        password: Password(''),
        passwordConfirmation: PasswordConfirmation('', ''),
        showErrorMessages: false,
        isSubmitting: false,
        authFailureOrSuccessOption: none(),
      );

  // const factory SignUpFormState.initial() = _Initial;
  // const factory SignUpFormState.submitting() = _Submitting;
  // const factory SignUpFormState.email({
  //   required EmailAddress emailAddress,
  // }) = _Email;
  // const factory SignUpFormState.password({
  //   required Password password,
  //   required PasswordConfirmation passwordConfirmation,
  // }) = _Password;
  // const factory SignUpFormState.validationMessages({
  //   required bool show,
  // }) = _ValidationMessages;
  // const factory SignUpFormState.authRequest({
  //   required Either<AuthFailure, Unit> failureOrSuccess,
  // }) = _AuthRequest;
}

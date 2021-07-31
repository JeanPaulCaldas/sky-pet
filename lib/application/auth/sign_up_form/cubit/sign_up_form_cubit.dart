import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sky_pet/domain/auth/auth_failure.dart';
import 'package:sky_pet/domain/auth/value_objects.dart';
import 'package:sky_pet/domain/usecases/auth/credential_sign_up.dart';
import 'package:sky_pet/domain/usecases/auth/google_sign_in.dart';

part 'sign_up_form_state.dart';
part 'sign_up_form_cubit.freezed.dart';

@injectable
class SignUpFormCubit extends Cubit<SignUpFormState> {
  final CredentialSignUp _credentialSignUp;
  final GoogleSignIn _googleSignIn;

  SignUpFormCubit(this._credentialSignUp, this._googleSignIn)
      : super(SignUpFormState.initial());

  void emailChanged(String emailStr) {
    emit(
      state.copyWith(
        emailAddress: EmailAddress(emailStr),
        authFailureOrSuccessOption: none(),
      ),
    );
  }

  void passwordChanged(String passwordStr) {
    emit(
      state.copyWith(
        password: Password(passwordStr),
        authFailureOrSuccessOption: none(),
      ),
    );
  }

  void passwordConfirmationChanged(String passwordConfirmationStr) {
    emit(
      state.copyWith(
        passwordConfirmation: PasswordConfirmation(
            passwordConfirmationStr, state.password.getOrCrash()),
        authFailureOrSuccessOption: none(),
      ),
    );
  }

  Future<void> emailAndPassSignUp() async {
    Either<AuthFailure, Unit>? failureOrSuccess;
    final isEmailValid = state.emailAddress.isValid();
    final isPasswordValid = state.password.isValid();
    final isPasswordConfirmationValid = state.passwordConfirmation.isValid();

    if ([isEmailValid, isPasswordValid, isPasswordConfirmationValid]
        .every((element) => true)) {
      emit(state.copyWith(
          isSubmitting: true, authFailureOrSuccessOption: none()));

      failureOrSuccess = await _credentialSignUp(
          email: state.emailAddress, password: state.password);
    }

    emit(state.copyWith(
        isSubmitting: false,
        showErrorMessages: true,
        authFailureOrSuccessOption: optionOf(failureOrSuccess)));
  }

  Future<void> googleSignIn() async {
    emit(
        state.copyWith(isSubmitting: true, authFailureOrSuccessOption: none()));

    final failureOrSuccess = await _googleSignIn();

    emit(state.copyWith(
        isSubmitting: false,
        authFailureOrSuccessOption: some(failureOrSuccess)));
  }
}

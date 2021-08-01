import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sky_pet/domain/auth/auth_failure.dart';
import 'package:sky_pet/domain/auth/value_objects.dart';
import 'package:sky_pet/domain/usecases/auth/credential_sign_in.dart';

part 'sign_in_form_state.dart';
part 'sign_in_form_cubit.freezed.dart';

@injectable
class SignInFormCubit extends Cubit<SignInFormState> {
  final CredentialSignIn _credentialSignIn;

  SignInFormCubit(this._credentialSignIn) : super(SignInFormState.initial());

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

  Future<void> emailAndPassSignIn() async {
    Either<AuthFailure, Unit>? failureOrSuccess;
    final isEmailValid = state.emailAddress.isValid();
    final isPasswordValid = state.password.isValid();

    if (![isEmailValid, isPasswordValid].contains(false)) {
      emit(state.copyWith(
          isSubmitting: true, authFailureOrSuccessOption: none()));

      failureOrSuccess = await _credentialSignIn(
          email: state.emailAddress, password: state.password);
    }

    emit(state.copyWith(
        isSubmitting: false,
        showErrorMessages: true,
        authFailureOrSuccessOption: optionOf(failureOrSuccess)));
  }
}

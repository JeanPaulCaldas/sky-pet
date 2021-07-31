import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sky_pet/domain/auth/auth_failure.dart';
import 'package:sky_pet/domain/auth/value_objects.dart';
import 'package:sky_pet/domain/usecases/auth/credential_sign_up.dart';
import 'package:sky_pet/domain/usecases/auth/google_sign_in.dart';

part 'sign_up_form_state.dart';
part 'sign_up_form_cubit.freezed.dart';

class SignUpFormCubit extends Cubit<SignUpFormState> {
  final CredentialSignUp _credentialSignUp;
  final GoogleSignIn _googleSignIn;

  SignUpFormCubit(this._credentialSignUp, this._googleSignIn)
      : super(SignUpFormState.initial());

  void emailChanged(String emailStr) {}

  void passwordChanged(String passwordStr) {}

  void passwordConfirmationChanged(String passwordConfirmationStr) {}

  Future<void> emailAndPassSignIn() async {
    final isEmailValid = state.emailAddress.isValid();
    final isPasswordValid = state.password.isValid();
    //if (isEmailValid && isPasswordValid)
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

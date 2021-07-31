import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:sky_pet/domain/usecases/auth/credential_sign_in.dart';
import 'package:sky_pet/domain/usecases/auth/facebook_sign_in.dart';
import 'package:sky_pet/domain/usecases/auth/google_sign_in.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final CredentialSignIn? credentialSignIn;
  final GoogleSignIn? googleSignIn;
  final FacebookSignIn? facebookSignIn;

  SignInCubit({this.credentialSignIn, this.googleSignIn, this.facebookSignIn})
      : super(const SignInState._());

  void emailChanged(String value) {
    // final email = Email.dirty(value);
    // emit(state.copyWith(
    //   email: email,
    //   status: Formz.validate([email, state.password]),
    // ));
  }

  void passwordChanged(String value) {
    // final password = Password.dirty(value);
    // emit(state.copyWith(
    //   password: password,
    //   status: Formz.validate([state.email, password]),
    // ));
  }

  Future<void> signInWithCredentials() async {
    // if (!state.status.isValidated) return;
    // emit(state.copyWith(status: FormzStatus.submissionInProgress));
    // final x =
    //     await credentialSignIn!('state.email.value, state.password.value', '');
    // x.fold((l) => emit(state.copyWith(status: FormzStatus.submissionFailure)),
    //     (r) => emit(state.copyWith(status: FormzStatus.submissionSuccess)));
  }

  Future<void> signInWithGoogle() async {}
  Future<void> signInWithFacebook() async {}
}

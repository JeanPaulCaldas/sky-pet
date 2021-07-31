import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_form_state.dart';
part 'sign_in_form_cubit.freezed.dart';

class SignInFormCubit extends Cubit<SignInFormState> {
  SignInFormCubit() : super(const _Initial());
}

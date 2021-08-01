// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i5;

import 'application/auth/auth_bloc.dart' as _i20;
import 'application/auth/sign_in_form/cubit/sign_in_form_cubit.dart' as _i17;
import 'application/auth/sign_in_form/sign_in_form_bloc.dart' as _i7;
import 'application/auth/sign_up_form/cubit/sign_up_form_cubit.dart' as _i19;
import 'core/network_info.dart' as _i6;
import 'data/datasources/auth_firebase_data_source.dart' as _i9;
import 'data/repositories/auth/auth_repository_impl.dart' as _i11;
import 'domain/auth/i_auth_facade.dart' as _i8;
import 'domain/auth/i_auth_repository.dart' as _i10;
import 'domain/usecases/auth/auth_user_state.dart' as _i12;
import 'domain/usecases/auth/credential_sign_in.dart' as _i13;
import 'domain/usecases/auth/credential_sign_up.dart' as _i14;
import 'domain/usecases/auth/google_sign_in.dart' as _i16;
import 'domain/usecases/auth/sign_out.dart' as _i18;
import 'infrastructure/auth/firebase_auth_facade.dart' as _i15;
import 'infrastructure/core/firebase_injectable_module.dart'
    as _i21; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  gh.lazySingleton<_i3.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<_i4.GoogleSignIn>(
      () => firebaseInjectableModule.googleSignIn);
  gh.lazySingleton<_i5.InternetConnectionChecker>(
      () => firebaseInjectableModule.internetConnChecker);
  gh.lazySingleton<_i6.NetworkInfo>(() => _i6.NetworkInfoImpl(
      connectionChecker: get<_i5.InternetConnectionChecker>()));
  gh.factoryParam<_i7.SignInFormBloc, _i8.IAuthFacade?, dynamic>(
      (authFacade, _) => _i7.SignInFormBloc(authFacade: authFacade));
  gh.lazySingleton<_i9.AuthFirebaseDataSource>(() =>
      _i9.AuthFirebaseDataSourceImpl(
          firebaseAuth: get<_i3.FirebaseAuth>(),
          googleSignIn: get<_i4.GoogleSignIn>()));
  gh.lazySingleton<_i10.AuthRepository>(() => _i11.AuthRepositoryImpl(
      get<_i9.AuthFirebaseDataSource>(), get<_i6.NetworkInfo>()));
  gh.lazySingleton<_i12.AuthUserState>(
      () => _i12.AuthUserState(repository: get<_i10.AuthRepository>()));
  gh.lazySingleton<_i13.CredentialSignIn>(
      () => _i13.CredentialSignIn(repository: get<_i10.AuthRepository>()));
  gh.lazySingleton<_i14.CredentialSignUp>(
      () => _i14.CredentialSignUp(repository: get<_i10.AuthRepository>()));
  gh.lazySingleton<_i15.FirebaseAuthFacade>(() => _i15.FirebaseAuthFacade(
      firebaseAuth: get<_i3.FirebaseAuth>(),
      googleSignIn: get<_i4.GoogleSignIn>()));
  gh.lazySingleton<_i16.GoogleSignIn>(
      () => _i16.GoogleSignIn(repository: get<_i10.AuthRepository>()));
  gh.factory<_i17.SignInFormCubit>(
      () => _i17.SignInFormCubit(get<_i13.CredentialSignIn>()));
  gh.lazySingleton<_i18.SignOut>(
      () => _i18.SignOut(repository: get<_i10.AuthRepository>()));
  gh.factory<_i19.SignUpFormCubit>(() => _i19.SignUpFormCubit(
      get<_i14.CredentialSignUp>(), get<_i16.GoogleSignIn>()));
  gh.factory<_i20.AuthBloc>(() => _i20.AuthBloc(
      authUserState: get<_i12.AuthUserState>(), signOut: get<_i18.SignOut>()));
  return get;
}

class _$FirebaseInjectableModule extends _i21.FirebaseInjectableModule {}

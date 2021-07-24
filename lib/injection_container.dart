import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sky_pet/core/network_info.dart';
import 'package:sky_pet/data/datasources/auth_firebase_data_source.dart';
import 'package:sky_pet/data/repositories/auth/auth_repository_impl.dart';
import 'package:sky_pet/domain/repositories/auth_repository.dart';
import 'package:sky_pet/domain/usecases/auth/credential_sign_in.dart';
import 'package:sky_pet/domain/usecases/auth/credential_sign_up.dart';
import 'package:sky_pet/domain/usecases/auth/facebook_sign_in.dart';
import 'package:sky_pet/presentation/login/bloc/auth_login_bloc.dart';
import 'package:sky_pet/presentation/login/cubit/sign_in_cubit.dart';

import 'domain/usecases/auth/google_sign_in.dart';

final sl = GetIt.I;

void init() {
  //! Features
  sl.registerFactory(() => AuthLoginBloc(
        credentialSignIn: sl(),
        credentialSignUp: sl(),
      ));
  sl.registerFactory(() => SignInCubit(
        credentialSignIn: sl(),
        googleSignIn: sl(),
        facebookSignIn: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => CredentialSignIn(sl()));
  sl.registerLazySingleton(() => CredentialSignUp(sl()));
  sl.registerLazySingleton(() => GoogleSignIn(sl()));
  sl.registerLazySingleton(() => FacebookSignIn(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        networkInfo: sl(),
        firebaseDataSource: sl(),
      ));

  // Data sources
  sl.registerLazySingleton<AuthFirebaseDataSource>(
      () => AuthFirebaseDataSourceImpl(firebaseAuth: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => FirebaseAuth.instance);
}

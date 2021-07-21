import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sky_pet/core/network_info.dart';
import 'package:sky_pet/data/datasources/auth_remote_data_source.dart';
import 'package:sky_pet/data/repositories/auth/auth_repository_impl.dart';
import 'package:sky_pet/domain/repositories/auth_repository.dart';
import 'package:sky_pet/domain/usecases/auth/email_sign_in.dart';
import 'package:sky_pet/domain/usecases/auth/email_sign_up.dart';
import 'package:sky_pet/presentation/login/bloc/auth_login_bloc.dart';

final sl = GetIt.I;

void init() {
  //! Features
  sl.registerFactory(() => AuthLoginBloc(emailSignIn: sl(), emailSignUp: sl()));

  // Use cases
  sl.registerLazySingleton(() => EmailSignIn(sl()));
  sl.registerLazySingleton(() => EmailSignUp(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        networkInfo: sl(),
        remoteDataSource: sl(),
      ));

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(firebaseAuth: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => FirebaseAuth.instance);
}

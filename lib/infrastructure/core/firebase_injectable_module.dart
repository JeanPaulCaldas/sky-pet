import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

@module
abstract class FirebaseInjectableModule {
  @lazySingleton
  GoogleSignIn get googleSignIn => GoogleSignIn();
  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
  @lazySingleton
  InternetConnectionChecker get internetConnChecker =>
      InternetConnectionChecker();
}

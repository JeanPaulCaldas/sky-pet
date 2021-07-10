import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future<bool> emailSignIn(String email, String password);
  Future<bool> emailSignUp(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceImpl({this.firebaseAuth});

  @override
  Future<bool> emailSignIn(String email, String password) async {
    await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return true;
  }

  @override
  Future<bool> emailSignUp(String email, String password) async {
    await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return true;
  }
}

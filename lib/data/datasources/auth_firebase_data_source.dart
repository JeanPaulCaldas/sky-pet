import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:sky_pet/domain/auth/auth_failure.dart';
import 'package:sky_pet/domain/auth/user.dart' as d;
import 'package:sky_pet/domain/auth/value_objects.dart';
import 'package:sky_pet/domain/core/value_objects.dart';

abstract class AuthFirebaseDataSource {
  Stream<Option<d.User>> get userState;

  Future<Either<AuthFailure, Unit>> signInWithCredentials({
    required EmailAddress emailAddress,
    required Password password,
  });

  Future<Either<AuthFailure, Unit>> signInWithGoogle();

  Future<Either<AuthFailure, Unit>> signUpWithCredentials({
    required EmailAddress emailAddress,
    required Password password,
  });
  Future<void> signOut();
}

@LazySingleton(as: AuthFirebaseDataSource)
class AuthFirebaseDataSourceImpl implements AuthFirebaseDataSource {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthFirebaseDataSourceImpl(
      {required FirebaseAuth firebaseAuth, required GoogleSignIn googleSignIn})
      : _firebaseAuth = firebaseAuth,
        _googleSignIn = googleSignIn;

  @override
  Stream<Option<d.User>> get userState => _firebaseAuth
      .authStateChanges()
      .map((firebaseUser) => optionOf(firebaseUser?.toDomain));

  @override
  Future<Either<AuthFailure, Unit>> signInWithCredentials(
      {required EmailAddress emailAddress, required Password password}) async {
    final emailAddressStr = emailAddress.getOrCrash();
    final passwordStr = password.getOrCrash();
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: emailAddressStr, password: passwordStr);
      return right(unit);
    } on PlatformException catch (e) {
      return left(['user-not-found', 'wrong-password'].contains(e.code)
          ? const AuthFailure.invalidCredentials()
          : const AuthFailure.serverError());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithGoogle() async {
    try {
      final googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount == null) {
        return left(const AuthFailure.cancelledByUser());
      }
      final googleAuth = await googleSignInAccount.authentication;
      final authCredential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      await _firebaseAuth.signInWithCredential(authCredential);
      return right(unit);
    } on PlatformException catch (_) {
      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<void> signOut() async {
    Future.wait([
      _googleSignIn.signOut(),
      _firebaseAuth.signOut(),
    ]);
  }

  @override
  Future<Either<AuthFailure, Unit>> signUpWithCredentials(
      {required EmailAddress emailAddress, required Password password}) async {
    final emailAddressStr = emailAddress.getOrCrash();
    final passwordStr = password.getOrCrash();
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: emailAddressStr, password: passwordStr);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return left(e.code == 'email-already-in-use'
          ? const AuthFailure.emailAlreadyInUse()
          : const AuthFailure.serverError());
    }
  }
}

extension on User {
  d.User get toDomain {
    return d.User(
      id: UniqueId.fromUniqueString(uid),
      name: displayName,
      email: email,
    );
  }
}

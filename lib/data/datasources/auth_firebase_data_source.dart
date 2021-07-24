import 'package:firebase_auth/firebase_auth.dart';
import 'package:sky_pet/domain/models/user_model.dart';

abstract class AuthFirebaseDataSource {
  Future<void> credentialsSignIn(String email, String password);
  Future<void> credentialsSignUp(String email, String password);
  Future<UserModel> get currentUser;
  Future<void> facebookSignIn();
  Future<void> googleSignIn();
  Future<void> signOut();
  Stream<UserModel> get user;
}

class AuthFirebaseDataSourceImpl implements AuthFirebaseDataSource {
  final FirebaseAuth firebaseAuth;

  AuthFirebaseDataSourceImpl({this.firebaseAuth});

  @override
  Future<void> credentialsSignIn(String email, String password) async {
    await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> credentialsSignUp(String email, String password) async {
    await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  // TODO: implement currentUser
  Future<UserModel> get currentUser async =>
      _getUserModel(firebaseAuth.currentUser);

  @override
  Future<void> facebookSignIn() {
    // TODO: implement facebookSignIn
    throw UnimplementedError();
  }

  @override
  Future<void> googleSignIn() {
    // TODO: implement googleSignIn
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Stream<UserModel> get user {
    return firebaseAuth
        .authStateChanges()
        .map((firebaseUser) => _getUserModel(firebaseUser));
  }

  UserModel _getUserModel(User firebaseUser) =>
      firebaseUser == null ? UserModel.empty : firebaseUser.toUserModel;
}

extension on User {
  UserModel get toUserModel {
    return UserModel(id: uid, email: email, name: displayName);
  }
}

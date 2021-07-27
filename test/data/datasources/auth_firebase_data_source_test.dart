import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sky_pet/data/datasources/auth_firebase_data_source.dart';
import 'package:sky_pet/domain/models/user_model.dart';

class MockFirebaseAuth extends Mock implements firebase_auth.FirebaseAuth {}

class MockUserCredential extends Mock implements firebase_auth.UserCredential {}

class MockFirebaseUser extends Mock implements firebase_auth.User {}

void main() {
  late AuthFirebaseDataSourceImpl dataSource;
  late MockFirebaseAuth mockFirebaseAuth;
  MockUserCredential? mockUserCredential;
  late MockFirebaseUser mockFirebaseUser;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockUserCredential = MockUserCredential();
    mockFirebaseUser = MockFirebaseUser();
    dataSource = AuthFirebaseDataSourceImpl(firebaseAuth: mockFirebaseAuth);
  });

  group('Credentials', () {
    final tEmail = 'mail@mail.com';
    final tPass = 'securePass!';
    final tUserCredential = Future.value(mockUserCredential);

    test('should sign in when there are valid credentials', () async {
      //arrange
      when(mockFirebaseAuth.signInWithEmailAndPassword(
              email: tEmail, password: tPass))
          .thenAnswer((_) => tUserCredential);
      //act
      await dataSource.credentialsSignIn(tEmail, tPass);
      //assert
      verify(mockFirebaseAuth.signInWithEmailAndPassword(
          email: tEmail, password: tPass));
    });

    test('should sign up when there are valid credentials', () async {
      //arrange
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
              email: tEmail, password: tPass))
          .thenAnswer((_) => tUserCredential);
      //act
      await dataSource.credentialsSignUp(tEmail, tPass);
      //assert
      verify(mockFirebaseAuth.createUserWithEmailAndPassword(
          email: tEmail, password: tPass));
    });
  });

  group('User stream', () {
    final _userUid = 'mock_uid';
    final _userEmail = 'mock_email';
    final user = UserModel(id: _userUid, email: _userEmail);

    test('should emits user model empty instance when firebase user is null',
        () async {
      when(mockFirebaseAuth.authStateChanges())
          .thenAnswer((_) => Stream.value(null));
      //act - assert
      expectLater(dataSource.user, emitsInOrder([UserModel.empty]));
    });

    test('should emits user model instance when firebase user is not null',
        () async {
      //arrange
      when(mockFirebaseUser.uid).thenReturn(_userUid);
      when(mockFirebaseUser.email).thenReturn(_userEmail);
      when(mockFirebaseAuth.authStateChanges())
          .thenAnswer((_) => Stream.value(mockFirebaseUser));
      //act - assert
      expectLater(dataSource.user, emitsInOrder([user]));
    });
  });
}

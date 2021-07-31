import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sky_pet/data/datasources/auth_firebase_data_source.dart';
import 'package:sky_pet/domain/auth/user.dart';
import 'package:sky_pet/domain/auth/value_objects.dart';
import 'package:sky_pet/domain/core/value_objects.dart';

class MockFirebaseAuth extends Mock implements firebase_auth.FirebaseAuth {}

class MockUserCredential extends Mock implements firebase_auth.UserCredential {}

class MockFirebaseUser extends Mock implements firebase_auth.User {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

void main() {
  late AuthFirebaseDataSourceImpl dataSource;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockUserCredential mockUserCredential;
  late MockFirebaseUser mockFirebaseUser;
  late MockGoogleSignIn mockGoogleSignIn;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockUserCredential = MockUserCredential();
    mockFirebaseUser = MockFirebaseUser();
    mockGoogleSignIn = MockGoogleSignIn();
    dataSource = AuthFirebaseDataSourceImpl(
        firebaseAuth: mockFirebaseAuth, googleSignIn: mockGoogleSignIn);
  });

  group('Credentials', () {
    final tEmail = EmailAddress('mail@mail.com');
    final tPass = Password('securePass!');
    final tUserCredential = Future.value(mockUserCredential);

    test('should sign in when there are valid credentials', () async {
      //arrange
      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
          email: any(), password: any())).thenAnswer((_) => tUserCredential);
      //act
      await dataSource.signInWithCredentials(
          emailAddress: tEmail, password: tPass);
      //assert
      verify(() => mockFirebaseAuth.signInWithEmailAndPassword(
          email: tEmail.getOrCrash(), password: tPass.getOrCrash()));
    });

    test('should sign up when there are valid credentials', () async {
      //arrange
      when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
          email: any(), password: any())).thenAnswer((_) => tUserCredential);
      //act
      await dataSource.signUpWithCredentials(
          emailAddress: tEmail, password: tPass);
      //assert
      verify(() => mockFirebaseAuth.createUserWithEmailAndPassword(
          email: tEmail.getOrCrash(), password: tPass.getOrCrash()));
    });
  });

  group('User stream', () {
    final _userUid = 'mock_uid';
    final _userEmail = 'mock_email';
    final user = User(id: UniqueId());

    test('should emits domain user empty instance when firebase user is null',
        () async {
      when(() => mockFirebaseAuth.authStateChanges())
          .thenAnswer((_) => Stream.value(null));
      //act - assert
      expectLater(dataSource.getSignedInUser(), emitsInOrder([none()]));
    });

    test('should emits domain user instance when firebase user is not null',
        () async {
      //arrange
      when(() => mockFirebaseUser.uid).thenReturn(_userUid);
      when(() => mockFirebaseUser.email).thenReturn(_userEmail);
      when(() => mockFirebaseAuth.authStateChanges())
          .thenAnswer((_) => Stream.value(mockFirebaseUser));
      //act - assert
      expectLater(dataSource.getSignedInUser(), emitsInOrder([some(user)]));
    });
  });
}

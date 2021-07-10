import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sky_pet/data/datasources/auth_remote_data_source.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  AuthRemoteDataSourceImpl dataSource;
  MockFirebaseAuth mockFirebaseAuth;
  MockUserCredential mockUserCredential;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockUserCredential = MockUserCredential();
    dataSource = AuthRemoteDataSourceImpl(firebaseAuth: mockFirebaseAuth);
  });

  group('emailSignIn', () {
    final tEmail = 'mail@mail.com';
    final tPass = 'securePass!';
    final tUserCredential = Future.value(mockUserCredential);

    test('should sign in when there are valid credentials', () async {
      //arrange
      when(mockFirebaseAuth.signInWithEmailAndPassword(
              email: tEmail, password: tPass))
          .thenAnswer((_) => tUserCredential);
      //act
      final result = await dataSource.emailSignIn(tEmail, tPass);
      //assert
      verify(mockFirebaseAuth.signInWithEmailAndPassword(
          email: tEmail, password: tPass));
      expect(result, true);
    });

    test('should sign up when there are valid credentials', () async {
      //arrange
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
              email: tEmail, password: tPass))
          .thenAnswer((_) => tUserCredential);
      //act
      final result = await dataSource.emailSignUp(tEmail, tPass);
      //assert
      verify(mockFirebaseAuth.createUserWithEmailAndPassword(
          email: tEmail, password: tPass));
      expect(result, true);
    });
  });
}

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sky_pet/core/failures.dart';
import 'package:sky_pet/core/network_info.dart';
import 'package:sky_pet/data/datasources/auth_firebase_data_source.dart';
import 'package:sky_pet/data/repositories/auth/auth_repository_impl.dart';
import 'package:sky_pet/domain/auth/user.dart' as d;
import 'package:sky_pet/domain/auth/value_objects.dart';
import 'package:sky_pet/domain/core/value_objects.dart';

class MockFirebaseDataSource extends Mock implements AuthFirebaseDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late AuthRepositoryImpl repository;
  late MockFirebaseDataSource mockFirebaseDataSource;
  late MockNetworkInfo mockNetworkInfo;

  final tEmail = EmailAddress('abc@mail.com');
  final tPass = Password('123456');

  setUp(() {
    mockFirebaseDataSource = MockFirebaseDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = AuthRepositoryImpl(
      firebaseDataSource: mockFirebaseDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTest({required bool online, Function? body}) {
    group('device is ${(online ? 'online' : 'offline')}', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => online);
      });

      body!();
    });
  }

  group('Credential SignIn', () {
    test('should check for connectivity', () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      //act
      repository.signInWithEmailAndPass(email: tEmail, password: tPass);
      //assert
      verify(() => mockNetworkInfo.isConnected);
    });

    runTest(
        online: true,
        body: () {
          test(
              'should return unit value when the call to firebase data source is successfull',
              () async {
            //arrange
            when(() => mockFirebaseDataSource.signInWithCredentials(
                emailAddress: any(),
                password: any())).thenAnswer((_) async => Right(unit));
            //act
            final result = await repository.signInWithEmailAndPass(
                email: tEmail, password: tPass);
            //assert
            verify(() => mockFirebaseDataSource.signInWithCredentials(
                emailAddress: tEmail, password: tPass));
            expect(result, equals(Right(unit)));
          });

          test(
              'should return firebase failure when the call to firebase data source is unsuccessful',
              () async {
            //arrange
            when(() => mockFirebaseDataSource.signInWithCredentials(
                    emailAddress: any(), password: any()))
                .thenThrow(FirebaseAuthException(code: 'code'));
            //act
            final result = await repository.signInWithEmailAndPass(
                email: tEmail, password: tPass);
            //assert
            verify(() => mockFirebaseDataSource.signInWithCredentials(
                emailAddress: tEmail, password: tPass));
            expect(result, equals(Left(FirebaseFailure())));
          });
        });

    runTest(
        online: false,
        body: () {
          test(
              'should return network failure when network info is not connected',
              () async {
            //act
            final result = await repository.signInWithEmailAndPass(
                email: tEmail, password: tPass);
            //assert
            verifyZeroInteractions(mockFirebaseDataSource);
            expect(result, equals(Left(NetworkFailure())));
          });
        });
  });

  group('Credentials SignUp', () {
    test('should check for connectivity', () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      //act
      repository.signUpWithEmailAndPass(email: tEmail, password: tPass);
      //assert
      verify(() => mockNetworkInfo.isConnected);
    });

    runTest(
        online: true,
        body: () {
          test(
              'should return data when call to firebase data source is successful',
              () async {
            //arrange
            when(() => mockFirebaseDataSource.signInWithCredentials(
                emailAddress: any(),
                password: any())).thenAnswer((_) async => Right(unit));
            //act
            final response = await repository.signUpWithEmailAndPass(
                email: tEmail, password: tPass);
            //assert
            verify(() => mockFirebaseDataSource.signInWithCredentials(
                emailAddress: tEmail, password: tPass));
            verifyNoMoreInteractions(mockFirebaseDataSource);
            expect(response, Right(unit));
          });

          test(
              'should return firebase failure when the call to firebase data source is unsuccessful',
              () async {
            //arrange
            when(() => mockFirebaseDataSource.signInWithCredentials(
                    emailAddress: any(), password: any()))
                .thenThrow(FirebaseAuthException(code: 'code'));
            //act
            final result = await repository.signInWithEmailAndPass(
                email: tEmail, password: tPass);
            //assert
            verify(() => mockFirebaseDataSource.signInWithCredentials(
                emailAddress: tEmail, password: tPass));
            verifyNoMoreInteractions(mockFirebaseDataSource);
            expect(result, equals(Left(FirebaseFailure())));
          });
        });

    runTest(
        online: false,
        body: () {
          test(
              'should return network failure when network info is not connected',
              () async {
            //act
            final result = await repository.signInWithEmailAndPass(
                email: tEmail, password: tPass);
            //assert
            verifyZeroInteractions(mockFirebaseDataSource);
            expect(result, equals(Left(NetworkFailure())));
          });
        });
  });

  group('User stream', () {
    final tUser = some(d.User(id: UniqueId()));
    test('should emits empty user when firebase user is null', () async {
      //arrange
      when(() => mockFirebaseDataSource.getSignedInUser())
          .thenAnswer((_) => Stream.value(tUser));
      //act - assert
      expectLater(repository.user, emitsInOrder([tUser]));
    });

    test('should emits user model instance when firebase user is not null',
        () async {
      //arrange
      when(() => mockFirebaseDataSource.getSignedInUser())
          .thenAnswer((_) => Stream.value(tUser));
      //act - assert
      expectLater(repository.user, emitsInOrder([tUser]));
    });
  });
}

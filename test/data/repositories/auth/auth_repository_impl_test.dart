import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sky_pet/core/exceptions.dart';
import 'package:sky_pet/core/failures.dart';
import 'package:sky_pet/core/network_info.dart';
import 'package:sky_pet/data/datasources/auth_firebase_data_source.dart';
import 'package:sky_pet/data/repositories/auth/auth_repository_impl.dart';
import 'package:sky_pet/domain/models/user_model.dart';

class MockFirebaseDataSource extends Mock implements AuthFirebaseDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  AuthRepositoryImpl repository;
  MockFirebaseDataSource mockFirebaseDataSource;
  MockNetworkInfo mockNetworkInfo;

  final tEmail = "abc@mail.com";
  final tPass = "123456";

  setUp(() {
    mockFirebaseDataSource = MockFirebaseDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = AuthRepositoryImpl(
      firebaseDataSource: mockFirebaseDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTest({bool online, Function body}) {
    group('device is ${(online ? 'online' : 'offline')}', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => online);
      });

      body();
    });
  }

  group('Credential SignIn', () {
    test('should check for connectivity', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      //act
      repository.credentialSignIn(tEmail, tPass);
      //assert
      verify(mockNetworkInfo.isConnected);
    });

    runTest(
        online: true,
        body: () {
          test(
              'should return null value when the call to firebase data source is successfull',
              () async {
            //arrange
            when(mockFirebaseDataSource.credentialsSignIn(any, any))
                .thenAnswer((_) async => null);
            //act
            final result = await repository.credentialSignIn(tEmail, tPass);
            //assert
            verify(mockFirebaseDataSource.credentialsSignIn(tEmail, tPass));
            expect(result, equals(Right(null)));
          });

          test(
              'should return firebase failure when the call to firebase data source is unsuccessful',
              () async {
            //arrange
            when(mockFirebaseDataSource.credentialsSignIn(tEmail, tPass))
                .thenThrow(FirebaseException());
            //act
            final result = await repository.credentialSignIn(tEmail, tPass);
            //assert
            verify(mockFirebaseDataSource.credentialsSignIn(tEmail, tPass));
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
            final result = await repository.credentialSignIn(tEmail, tPass);
            //assert
            verifyZeroInteractions(mockFirebaseDataSource);
            expect(result, equals(Left(NetworkFailure())));
          });
        });
  });

  group('Credentials SignUp', () {
    test('should check for connectivity', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      //act
      repository.credentialSignUp(tEmail, tPass);
      //assert
      verify(mockNetworkInfo.isConnected);
    });

    runTest(
        online: true,
        body: () {
          test(
              'should return data when call to firebase data source is successful',
              () async {
            //arrange
            when(mockFirebaseDataSource.credentialsSignUp(any, any))
                .thenAnswer((_) async => null);
            //act
            final response = await repository.credentialSignUp(tEmail, tPass);
            //assert
            verify(mockFirebaseDataSource.credentialsSignUp(tEmail, tPass));
            verifyNoMoreInteractions(mockFirebaseDataSource);
            expect(response, Right(null));
          });

          test(
              'should return firebase failure when the call to firebase data source is unsuccessful',
              () async {
            //arrange
            when(mockFirebaseDataSource.credentialsSignUp(tEmail, tPass))
                .thenThrow(FirebaseException());
            //act
            final result = await repository.credentialSignUp(tEmail, tPass);
            //assert
            verify(mockFirebaseDataSource.credentialsSignUp(tEmail, tPass));
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
            final result = await repository.credentialSignUp(tEmail, tPass);
            //assert
            verifyZeroInteractions(mockFirebaseDataSource);
            expect(result, equals(Left(NetworkFailure())));
          });
        });
  });

  group('User stream', () {
    test('should emits empty user when firebase user is null', () async {
      //arrange
      when(mockFirebaseDataSource.user)
          .thenAnswer((_) => Stream.value(UserModel.empty));
      //act - assert
      expectLater(
          repository.user, emitsInOrder(const <UserModel>[UserModel.empty]));
    });

    test('should emits user model instance when firebase user is not null',
        () async {
      //arrange
      final tUser = UserModel(id: '12', email: 'mail@mail.com', name: 'nombre');
      when(mockFirebaseDataSource.user).thenAnswer((_) => Stream.value(tUser));
      //act - assert
      expectLater(repository.user, emitsInOrder([tUser]));
    });
  });
}

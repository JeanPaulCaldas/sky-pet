import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sky_pet/core/exceptions.dart';
import 'package:sky_pet/core/failures.dart';
import 'package:sky_pet/core/network_info.dart';
import 'package:sky_pet/data/datasources/auth_remote_data_source.dart';
import 'package:sky_pet/data/models/user_model.dart';
import 'package:sky_pet/data/repositories/auth/auth_repository_impl.dart';
import 'package:sky_pet/domain/models/user.dart';

class MockRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  AuthRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;

  final tEmail = "abc@mail.com";
  final tPass = "123456";

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = AuthRepositoryImpl(
        remoteDataSource: mockRemoteDataSource, networkInfo: mockNetworkInfo);
  });

  void runTest({bool online, Function body}) {
    group('device is ${(online ? 'online' : 'offline')}', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => online);
      });

      body();
    });
  }

  group('Email and password SignIn', () {
    test('should check for connectivity', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      //act
      repository.emailSignIn(tEmail, tPass);
      //assert
      verify(mockNetworkInfo.isConnected);
    });

    runTest(
        online: true,
        body: () {
          test(
              'should return remote data when the call to firebase auth lib is successfull',
              () async {
            //arrange
            when(mockRemoteDataSource.emailSignIn(any, any))
                .thenAnswer((_) async => true);
            //act
            final result = await repository.emailSignIn(tEmail, tPass);
            //assert
            verify(mockRemoteDataSource.emailSignIn(tEmail, tPass));
            expect(result, equals(Right(true)));
          });

          test(
              'should return firebase failure when the call to firebase auth lib is unsuccessful',
              () async {
            //arrange
            when(mockRemoteDataSource.emailSignIn(tEmail, tPass))
                .thenThrow(FirebaseException());
            //act
            final result = await repository.emailSignIn(tEmail, tPass);
            //assert
            verify(mockRemoteDataSource.emailSignIn(tEmail, tPass));
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
            final result = await repository.emailSignIn(tEmail, tPass);
            //assert
            verifyZeroInteractions(mockRemoteDataSource);
            expect(result, equals(Left(NetworkFailure())));
          });
        });
  });

  group('Email and password SignUp', () {
    test('should check for connectivity', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      //act
      repository.emailSignUp(tEmail, tPass);
      //assert
      verify(mockNetworkInfo.isConnected);
    });

    runTest(
        online: true,
        body: () {
          test(
              'should return data when call to firebase auth service is successful',
              () async {
            //arrange
            when(mockRemoteDataSource.emailSignUp(any, any))
                .thenAnswer((_) async => true);
            //act
            final response = await repository.emailSignUp(tEmail, tPass);
            //assert
            verify(mockRemoteDataSource.emailSignUp(tEmail, tPass));
            verifyNoMoreInteractions(mockRemoteDataSource);
            expect(response, Right(true));
          });

          test(
              'should return firebase failure when the call to firebase auth service is unsuccessful',
              () async {
            //arrange
            when(mockRemoteDataSource.emailSignUp(tEmail, tPass))
                .thenThrow(FirebaseException());
            //act
            final result = await repository.emailSignUp(tEmail, tPass);
            //assert
            verify(mockRemoteDataSource.emailSignUp(tEmail, tPass));
            verifyNoMoreInteractions(mockRemoteDataSource);
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
            final result = await repository.emailSignUp(tEmail, tPass);
            //assert
            verifyZeroInteractions(mockRemoteDataSource);
            expect(result, equals(Left(NetworkFailure())));
          });
        });
  });
}

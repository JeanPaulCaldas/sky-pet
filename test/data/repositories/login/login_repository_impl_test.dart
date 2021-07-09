import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sky_pet/core/exceptions.dart';
import 'package:sky_pet/core/failures.dart';
import 'package:sky_pet/core/network_info.dart';
import 'package:sky_pet/data/datasources/login_local_data_source.dart';
import 'package:sky_pet/data/datasources/login_remote_data_source.dart';
import 'package:sky_pet/data/models/user_model.dart';
import 'package:sky_pet/data/repositories/login/login_repository_impl.dart';
import 'package:sky_pet/domain/models/user.dart';

class MockRemoteDataSource extends Mock implements LoginRemoteDataSource {}

class MockLocalDataSource extends Mock implements LoginLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  LoginRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = LoginRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo);
  });

  void runTest({bool online, Function body}) {
    group('device is ${(online ? 'online' : 'offline')}', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => online);
      });

      body();
    });
  }

  group('Login with email', () {
    final tEmail = "abc@mail.com";
    final tPass = "123456";
    final tUserModel = UserModel(id: '1', name: 'nombre');
    final User tUser = tUserModel;

    test('should check for connectivity', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      //act
      repository.emailLogin(tEmail, tPass);
      //assert
      verify(mockNetworkInfo.isConnected);
    });

    runTest(
        online: true,
        body: () {
          test(
              'should return remote data when the call to remote data source is successfull',
              () async {
            //arrange
            when(mockRemoteDataSource.emailLogin(any, any))
                .thenAnswer((_) async => tUserModel);
            //act
            final result = await repository.emailLogin(tEmail, tPass);
            //assert
            verify(mockRemoteDataSource.emailLogin(tEmail, tPass));
            expect(result, equals(Right(tUser)));
          });

          test(
              'should return firebase failure when the call to firebase lib is unsuccessful',
              () async {
            //arrange
            when(mockRemoteDataSource.emailLogin(tEmail, tPass))
                .thenThrow(FirebaseException());
            //act
            final result = await repository.emailLogin(tEmail, tPass);
            //assert
            verify(mockRemoteDataSource.emailLogin(tEmail, tPass));
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
            final result = await repository.emailLogin(tEmail, tPass);
            //assert
            verifyZeroInteractions(mockRemoteDataSource);
            expect(result, equals(Left(NetworkFailure())));
          });
        });
  });
}

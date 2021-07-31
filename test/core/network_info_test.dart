import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sky_pet/core/network_info.dart';

class MockInternetConnectionChecker extends Mock
    implements InternetConnectionChecker {}

void main() {
  late NetworkInfoImpl networkInfo;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfo =
        NetworkInfoImpl(connectionChecker: mockInternetConnectionChecker);
  });

  group('isConnected', () {
    test('should forward the call to InternetConnectionChecker.hasConnection',
        () async {
      final tHasConnection = Future.value(true);
      //arrange
      when(() => mockInternetConnectionChecker.hasConnection)
          .thenAnswer((_) => tHasConnection);
      //act
      final result = networkInfo.isConnected;
      //assert
      verify(() => mockInternetConnectionChecker.hasConnection);
      expect(result, tHasConnection);
    });
  });
}

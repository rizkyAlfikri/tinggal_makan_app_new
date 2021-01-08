import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tinggal_makan_app/core/network/network_info.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  NetworkInfoImpl networkInfoImpl;
  MockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(mockDataConnectionChecker);
  });

  test(
      'isConnected with return true should return true and called DataConnectionChecker.hasConnection',
      () async {
    // arrange
    final hasConnectionInFuture = Future.value(true);

    when(mockDataConnectionChecker.hasConnection)
        .thenAnswer((_) => hasConnectionInFuture);

    // act
    final result = networkInfoImpl.isConnected;

    // assert
    verify(mockDataConnectionChecker.hasConnection);
    expect(result, hasConnectionInFuture);
  });

  test(
      'isConnected with return false should return false and called DataConnectionChecker.hasConnection',
      () async {
    // arrange
    final hasConnectionInFuture = Future.value(false);

    when(mockDataConnectionChecker.hasConnection)
        .thenAnswer((_) => hasConnectionInFuture);

    // act
    final result = networkInfoImpl.isConnected;

    // assert
    verify(mockDataConnectionChecker.hasConnection);
    expect(result, hasConnectionInFuture);
  });
}

import 'package:dartz/dartz.dart';
import 'package:fintech_dark/core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _TestGuard with NetworkGuard {
  @override
  final NetworkInfo networkInfo;
  _TestGuard(this.networkInfo);
}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MockNetworkInfo networkInfo;
  late _TestGuard sut;

  setUp(() {
    networkInfo = MockNetworkInfo();
    sut = _TestGuard(networkInfo);
  });

  test('returns NetworkFailure when offline', () async {
    when(() => networkInfo.isConnected).thenAnswer((_) async => false);
    final result = await sut.guard(() async => 'value');
    expect(result, const Left(NetworkFailure()));
  });

  test('returns Right on success', () async {
    when(() => networkInfo.isConnected).thenAnswer((_) async => true);
    final result = await sut.guard(() async => 'value');
    expect(result, const Right('value'));
  });

  test('maps ServerException to ServerFailure', () async {
    when(() => networkInfo.isConnected).thenAnswer((_) async => true);
    final result = await sut.guard(
      () async => throw const ServerException('boom'),
    );
    expect(result, const Left(ServerFailure('boom')));
  });
}

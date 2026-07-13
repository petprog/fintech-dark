import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Simulated network/connectivity failure (timeout, offline, DNS, etc).
class NetworkFailure extends Failure {
  const NetworkFailure([
    super.message = 'No internet connection. Please check your network.',
  ]);
}

/// Simulated server-side failure (5xx, malformed payload).
class ServerFailure extends Failure {
  const ServerFailure([
    super.message = 'Something went wrong on our end. Please try again.',
  ]);
}

/// Local cache read/write failure.
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Unable to load saved data.']);
}

/// Fallback for anything unexpected — should be rare in practice.
class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'Something went wrong.']);
}

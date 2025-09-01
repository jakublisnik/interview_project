abstract class Failure {
  final String message;
  const Failure(this.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(String message) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}

class PermissionFailure extends Failure {
  const PermissionFailure(String m) : super(m);
}

class UnknownFailure extends Failure {
  const UnknownFailure(String message) : super(message);
}
abstract class Failure {
  final String message;
  final int? statusCode;

  Failure({required this.message, this.statusCode});
}

class ServerFailure extends Failure {
  ServerFailure({required super.message, super.statusCode});
}

class NetworkFailure extends Failure {
  NetworkFailure(
      {super.message = 'Unable to connect to the server', super.statusCode});
}

abstract class Failure {
  const Failure(this.message);
  final String? message;
}

class ServerFailure extends Failure {
  const ServerFailure({String? message}) : super(message);
}

class AddFailure extends Failure {
  const AddFailure({String? message}) : super(message);
}

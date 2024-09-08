import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]);

  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class DatabaseFailure extends Failure {}

class NetworkFailure extends Failure {}

class UnexpectedFailure extends Failure {
  final String message;

  const UnexpectedFailure(this.message);

  @override
  List<Object> get props => [message];
}

import 'package:dartz/dartz.dart';
import '../entities/todo.dart';
import '../../core/error/failures.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<Todo>>> getTodos();
  Future<Either<Failure, Todo>> addTodo(Todo todo);
  Future<Either<Failure, Todo>> updateTodo(Todo todo);
  Future<Either<Failure, Unit>> deleteTodo(String id);
}

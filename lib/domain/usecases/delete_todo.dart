// lib/domain/usecases/delete_todo.dart
import 'package:dartz/dartz.dart';
import '../../core/usecase/usecase.dart';
import '../repositories/todo_repository.dart';
import '../../core/error/failures.dart';

class DeleteTodo implements UseCase<Unit, DeleteTodoParams> {
  final TodoRepository repository;

  DeleteTodo(this.repository);

  @override
  Future<Either<Failure, Unit>> call(DeleteTodoParams params) async {
    return await repository.deleteTodo(params.id);
  }
}

class DeleteTodoParams {
  final String id;
  DeleteTodoParams(this.id);
}

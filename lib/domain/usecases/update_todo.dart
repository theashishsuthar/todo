import 'package:dartz/dartz.dart';
import '../../core/usecase/usecase.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';
import '../../core/error/failures.dart';

class UpdateTodo implements UseCase<Todo, UpdateTodoParams> {
  final TodoRepository repository;

  UpdateTodo(this.repository);

  @override
  Future<Either<Failure, Todo>> call(UpdateTodoParams params) async {
    return await repository.updateTodo(params.todo);
  }
}

class UpdateTodoParams {
  final Todo todo;
  UpdateTodoParams(this.todo);
}

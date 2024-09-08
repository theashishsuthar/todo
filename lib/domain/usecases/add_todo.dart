import 'package:dartz/dartz.dart';
import '../../core/usecase/usecase.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';
import '../../core/error/failures.dart';

class AddTodo implements UseCase<Todo, AddTodoParams> {
  final TodoRepository repository;

  AddTodo(this.repository);

  @override
  Future<Either<Failure, Todo>> call(AddTodoParams params) async {
    return await repository.addTodo(params.todo);
  }
}

class AddTodoParams {
  final Todo todo;
  AddTodoParams(this.todo);
}

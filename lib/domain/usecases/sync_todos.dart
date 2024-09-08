import 'package:dartz/dartz.dart';
import '../../core/usecase/usecase.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';
import '../../core/error/failures.dart';


class SyncTodos implements UseCase<List<Todo>, NoParams> {
  final TodoRepository repository;

  SyncTodos(this.repository);

  @override
  Future<Either<Failure, List<Todo>>> call(NoParams params) async {
    return await repository.getTodos();
  }
}

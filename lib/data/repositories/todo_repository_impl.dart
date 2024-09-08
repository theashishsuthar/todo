import 'package:dartz/dartz.dart';
import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/network_source.dart';
import '../datasources/todo_local_data_source.dart';
import '../datasources/todo_remote_data_source.dart';
import '../../core/error/failures.dart';
import '../models/todo_model.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource localDataSource;
  final TodoRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  TodoRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Todo>>> getTodos() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTodos = await remoteDataSource.getTodos();
        await localDataSource.cacheTodos(remoteTodos);
        return Right(remoteTodos.map((model) => model.toEntity()).toList());
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTodos = await localDataSource.getTodos();
        return Right(localTodos.map((model) => model.toEntity()).toList());
      } catch (e) {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Todo>> addTodo(Todo todo) async {
    final todoModel = TodoModel.fromEntity(todo);
    if (await networkInfo.isConnected) {
      try {
        final remoteTodo = await remoteDataSource.addTodo(todoModel);
        await localDataSource.addTodo(remoteTodo);
        return Right(remoteTodo.toEntity());
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTodo = await localDataSource.addTodo(todoModel);
        return Right(localTodo.toEntity());
      } catch (e) {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Todo>> updateTodo(Todo todo) async {
    final todoModel = TodoModel.fromEntity(todo);
    if (await networkInfo.isConnected) {
      try {
        final remoteTodo = await remoteDataSource.updateTodo(todoModel);
        await localDataSource.updateTodo(remoteTodo);
        return Right(remoteTodo.toEntity());
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTodo = await localDataSource.updateTodo(todoModel);
        return Right(localTodo.toEntity());
      } catch (e) {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTodo(String id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteTodo(id);
        await localDataSource.deleteTodo(id);
        return const Right(unit);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      try {
        await localDataSource.deleteTodo(id);
        return const Right(unit);
      } catch (e) {
        return Left(CacheFailure());
      }
    }
  }

   Future<Either<Failure, void>> syncTodos() async {
    if (await networkInfo.isConnected) {
      print('object');
      try {
        
        final unsyncedTodos = await localDataSource.getTodos();


        unsyncedTodos.removeWhere((e)=> e.isSynced);

        
        for (var todoModel in unsyncedTodos) {
          try {
            
            final remoteTodo = await remoteDataSource.addTodo(todoModel);

            await localDataSource.updateTodo(remoteTodo);
          } catch (e) {
            print("Failed to sync todo with ID: ${todoModel.id}, error: $e");
            return Left(ServerFailure()); 
          }
        }
        return const Right(null); 
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}

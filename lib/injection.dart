import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:todo/data/models/todo_model.dart';
import 'package:todo/domain/repositories/todo_repository.dart';
import 'package:todo/domain/usecases/sync_todos.dart';
import 'package:todo/firebase_options.dart';

import 'data/datasources/network_source.dart';
import 'data/datasources/todo_local_data_source.dart';
import 'data/datasources/todo_remote_data_source.dart';
import 'data/repositories/todo_repository_impl.dart';
import 'domain/usecases/get_todos.dart';
import 'domain/usecases/add_todo.dart';
import 'domain/usecases/update_todo.dart';
import 'domain/usecases/delete_todo.dart';
import 'presentation/bloc/todo_bloc.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
Future configureDependencies() => getIt.init();

@module
abstract class RegisterModule {
  @preResolve
  Future<FirebaseApp> get firebaseApp =>
      Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  @preResolve
  @Named('todoBox')
  Future<Box<TodoModel>> get todoBox => Hive.openBox<TodoModel>('todos');

  @lazySingleton
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  @lazySingleton
  TodoLocalDataSource todoLocalDataSource(
          @Named('todoBox') Box<TodoModel> todoBox) =>
      TodoLocalDataSourceImpl(todoBox: todoBox);

  @lazySingleton
  TodoRemoteDataSource todoRemoteDataSource(FirebaseFirestore firestore) =>
      TodoRemoteDataSourceImpl(firestore: firestore);

  @lazySingleton
  Connectivity get connectivity => Connectivity();

  @lazySingleton
  NetworkInfo networkInfo(Connectivity connectivity) =>
      NetworkInfoImpl(connectivity);
  

  @lazySingleton
  TodoRepository get todoRepository => TodoRepositoryImpl(
        localDataSource: getIt<TodoLocalDataSource>(),
        remoteDataSource: getIt<TodoRemoteDataSource>(),
        networkInfo: getIt<NetworkInfo>(),
      );

  @lazySingleton
  GetTodos getTodos(TodoRepository repository) => GetTodos(repository);

  @lazySingleton
  AddTodo addTodo(TodoRepository repository) => AddTodo(repository);

  @lazySingleton
  UpdateTodo updateTodo(TodoRepository repository) => UpdateTodo(repository);

  @lazySingleton
  DeleteTodo deleteTodo(TodoRepository repository) => DeleteTodo(repository);

  @lazySingleton
  SyncTodos syncTodo(TodoRepository repository) => SyncTodos(repository);

  @injectable
  TodoBloc todoBloc(GetTodos getTodos, AddTodo addTodo, UpdateTodo updateTodo,
      DeleteTodo deleteTodo,SyncTodos syncTodo) {
    return TodoBloc(
      getTodos: getTodos,
      addTodo: addTodo,
      updateTodo: updateTodo,
      deleteTodo: deleteTodo,
      syncTodos: syncTodo
    );
  }
}

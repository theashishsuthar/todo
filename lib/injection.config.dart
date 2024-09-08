// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:firebase_core/firebase_core.dart' as _i982;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive/hive.dart' as _i979;
import 'package:injectable/injectable.dart' as _i526;

import 'data/datasources/network_source.dart' as _i661;
import 'data/datasources/todo_local_data_source.dart' as _i603;
import 'data/datasources/todo_remote_data_source.dart' as _i777;
import 'data/models/todo_model.dart' as _i34;
import 'domain/repositories/todo_repository.dart' as _i476;
import 'domain/usecases/add_todo.dart' as _i985;
import 'domain/usecases/delete_todo.dart' as _i1037;
import 'domain/usecases/get_todos.dart' as _i752;
import 'domain/usecases/sync_todos.dart' as _i613;
import 'domain/usecases/update_todo.dart' as _i509;
import 'injection.dart' as _i464;
import 'presentation/bloc/todo_bloc.dart' as _i517;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i982.FirebaseApp>(
      () => registerModule.firebaseApp,
      preResolve: true,
    );
    gh.lazySingleton<_i974.FirebaseFirestore>(() => registerModule.firestore);
    gh.lazySingleton<_i895.Connectivity>(() => registerModule.connectivity);
    gh.lazySingleton<_i476.TodoRepository>(() => registerModule.todoRepository);
    gh.lazySingleton<_i661.NetworkInfo>(
        () => registerModule.networkInfo(gh<_i895.Connectivity>()));
    gh.lazySingleton<_i777.TodoRemoteDataSource>(() =>
        registerModule.todoRemoteDataSource(gh<_i974.FirebaseFirestore>()));
    gh.lazySingleton<_i752.GetTodos>(
        () => registerModule.getTodos(gh<_i476.TodoRepository>()));
    gh.lazySingleton<_i985.AddTodo>(
        () => registerModule.addTodo(gh<_i476.TodoRepository>()));
    gh.lazySingleton<_i509.UpdateTodo>(
        () => registerModule.updateTodo(gh<_i476.TodoRepository>()));
    gh.lazySingleton<_i1037.DeleteTodo>(
        () => registerModule.deleteTodo(gh<_i476.TodoRepository>()));
    gh.lazySingleton<_i613.SyncTodos>(
        () => registerModule.syncTodo(gh<_i476.TodoRepository>()));
    await gh.factoryAsync<_i979.Box<_i34.TodoModel>>(
      () => registerModule.todoBox,
      instanceName: 'todoBox',
      preResolve: true,
    );
    gh.factory<_i517.TodoBloc>(() => registerModule.todoBloc(
          gh<_i752.GetTodos>(),
          gh<_i985.AddTodo>(),
          gh<_i509.UpdateTodo>(),
          gh<_i1037.DeleteTodo>(),
          gh<_i613.SyncTodos>(),
        ));
    gh.lazySingleton<_i603.TodoLocalDataSource>(() =>
        registerModule.todoLocalDataSource(
            gh<_i979.Box<_i34.TodoModel>>(instanceName: 'todoBox')));
    return this;
  }
}

class _$RegisterModule extends _i464.RegisterModule {}

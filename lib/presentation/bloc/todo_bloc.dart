import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/usecases/sync_todos.dart';
import '../../core/error/failures.dart';
import '../../core/usecase/usecase.dart';
import '../../domain/usecases/get_todos.dart';
import '../../domain/usecases/add_todo.dart';
import '../../domain/usecases/update_todo.dart';
import '../../domain/usecases/delete_todo.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodos getTodos;
  final AddTodo addTodo;
  final UpdateTodo updateTodo;
  final DeleteTodo deleteTodo;
  final SyncTodos syncTodos;

  TodoBloc({
    required this.getTodos,
    required this.addTodo,
    required this.updateTodo,
    required this.deleteTodo,
    required this.syncTodos,
  }) : super(const TodoState.initial()) {
    on<TodoEvent>((event, emit) async {
      await event.map(
        getTodos: (_) => _onGetTodos(emit),
        addTodo: (e) => _onAddTodo(e, emit),
        updateTodo: (e) => _onUpdateTodo(e, emit),
        deleteTodo: (e) => _onDeleteTodo(e, emit),
        syncTodos:(e)=> _onSyncTodo(emit)
      );
    });
  }

  Future<void> _onGetTodos(Emitter<TodoState> emit) async {
    emit(const TodoState.loading());
    final failureOrTodos = await getTodos(NoParams());
    emit(failureOrTodos.fold(
      (failure) => TodoState.error(_mapFailureToMessage(failure)),
      (todos) => TodoState.loaded(todos),
    ));
  }

  Future<void> _onAddTodo(AddTodoEvent event, Emitter<TodoState> emit) async {
    final failureOrTodo = await addTodo(AddTodoParams(event.todo));
    failureOrTodo.fold(
      (failure) => emit(TodoState.error(_mapFailureToMessage(failure))),
      (_) => add(const TodoEvent.getTodos()),
    );
  }

  Future<void> _onUpdateTodo(
      UpdateTodoEvent event, Emitter<TodoState> emit) async {
    final failureOrTodo = await updateTodo(UpdateTodoParams(event.todo));
    failureOrTodo.fold(
      (failure) => emit(TodoState.error(_mapFailureToMessage(failure))),
      (_) => add(const TodoEvent.getTodos()),
    );
  }

  Future<void> _onDeleteTodo(
      DeleteTodoEvent event, Emitter<TodoState> emit) async {
    final failureOrVoid = await deleteTodo(DeleteTodoParams(event.id));
    failureOrVoid.fold(
      (failure) => emit(TodoState.error(_mapFailureToMessage(failure))),
      (_) => add(const TodoEvent.getTodos()),
    );
  }

  Future<void> _onSyncTodo(Emitter<TodoState> emit) async {
      emit(const TodoState.loading());
      final failureOrTodos = await syncTodos(NoParams());
      emit(failureOrTodos.fold(
        (failure) => TodoState.error(_mapFailureToMessage(failure)),
        (todos) => TodoState.loaded(todos),
      ));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return 'Server Failure';
      case CacheFailure _:
        return 'Cache Failure';
      default:
        return 'Unexpected Error';
    }
  }
}

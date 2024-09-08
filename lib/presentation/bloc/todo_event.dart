import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/todo.dart';

part 'todo_event.freezed.dart';

@freezed
class TodoEvent with _$TodoEvent {
  const factory TodoEvent.getTodos() = GetTodosEvent;
  const factory TodoEvent.addTodo(Todo todo) = AddTodoEvent;
  const factory TodoEvent.updateTodo(Todo todo) = UpdateTodoEvent;
  const factory TodoEvent.deleteTodo(String id) = DeleteTodoEvent;
  const factory TodoEvent.syncTodos() = SyncTodosEvent;
}

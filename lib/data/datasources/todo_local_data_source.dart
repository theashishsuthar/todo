import 'package:hive/hive.dart';
import '../models/todo_model.dart';

abstract class TodoLocalDataSource {
  Future<List<TodoModel>> getTodos();
  Future<void> cacheTodos(List<TodoModel> todos);
  Future<TodoModel> addTodo(TodoModel todo);
  Future<TodoModel> updateTodo(TodoModel todo);
  Future<void> deleteTodo(String id);
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  final Box<TodoModel> todoBox;

  TodoLocalDataSourceImpl({required this.todoBox});

  @override
  Future<List<TodoModel>> getTodos() async {
    return todoBox.values.toList();
  }

  @override
  Future<void> cacheTodos(List<TodoModel> todos) async {
    await todoBox.clear();
    await todoBox.addAll(todos);
  }

  @override
  Future<TodoModel> addTodo(TodoModel todo) async {
    await todoBox.put(todo.id, todo);
    return todo;
  }

  @override
  Future<TodoModel> updateTodo(TodoModel todo) async {
    await todoBox.put(todo.id, todo);
    return todo;
  }

  @override
  Future<void> deleteTodo(String id) async {
    await todoBox.delete(id);
  }
}

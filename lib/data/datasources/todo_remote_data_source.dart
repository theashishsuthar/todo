import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/todo_model.dart';

abstract class TodoRemoteDataSource {
  Future<List<TodoModel>> getTodos();
  Future<TodoModel> addTodo(TodoModel todo);
  Future<TodoModel> updateTodo(TodoModel todo);
  Future<void> deleteTodo(String id);
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final FirebaseFirestore firestore;

  TodoRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<TodoModel>> getTodos() async {
    final snapshot = await firestore.collection('todos').get();
    return snapshot.docs.map((doc) => TodoModel.fromJson(doc.data())).toList();
  }

  @override
  Future<TodoModel> addTodo(TodoModel todo) async {
    await firestore.collection('todos').doc(todo.id).set(todo.toJson());
    return todo;
  }

  @override
  Future<TodoModel> updateTodo(TodoModel todo) async {
    await firestore.collection('todos').doc(todo.id).update(todo.toJson());
    return todo;
  }

  @override
  Future<void> deleteTodo(String id) async {
    await firestore.collection('todos').doc(id).delete();
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/todo.dart';

part 'todo_model.freezed.dart';
part 'todo_model.g.dart';

@freezed
@HiveType(typeId: 0) 
class TodoModel with _$TodoModel {
  const factory TodoModel({
    @HiveField(0)
    required String id,
    @HiveField(1) required String title,
    @HiveField(2) required String description,
    @HiveField(3) @Default(false) bool isCompleted,
    @HiveField(4) @Default(true) bool isSynced,
  }) = _TodoModel;


  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);


  factory TodoModel.fromEntity(Todo todo) => TodoModel(
        id: todo.id,
        title: todo.title,
        description: todo.description,
        isCompleted: todo.isCompleted,
      );
}

extension TodoModelX on TodoModel {
  Todo toEntity() => Todo(
        id: id,
        title: title,
        description: description,
        isCompleted: isCompleted,
      );
}

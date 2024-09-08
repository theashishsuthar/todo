import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/todo.dart';
import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';
import '../widgets/todo_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditTodoPage extends StatelessWidget {
  final Todo todo;

  const EditTodoPage({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).updateTodo),
      ),
      body: TodoForm(
        initialTitle: todo.title,
        initialDescription: todo.description,
        onSubmit: (title, description) {
          final updatedTodo = todo.copyWith(
            title: title,
            description: description,
          );
          context.read<TodoBloc>().add(TodoEvent.updateTodo(updatedTodo));
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

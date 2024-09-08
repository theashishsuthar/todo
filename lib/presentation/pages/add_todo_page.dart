import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/todo.dart';
import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';
import '../widgets/network_status_widget.dart';
import '../widgets/todo_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTodoPage extends StatelessWidget {
  const AddTodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).addTodo),
      ),
      body: Column(
        children: [
          const NetworkStatusWidget(),
          TodoForm(
            onSubmit: (title, description) {
              final newTodo = Todo(
                id: DateTime.now().toString(),
                title: title,
                description: description,
              );
              context.read<TodoBloc>().add(TodoEvent.addTodo(newTodo));
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

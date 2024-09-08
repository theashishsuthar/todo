import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/presentation/bloc/todo_event.dart';
import 'package:todo/presentation/widgets/custom_checkbox.dart';
import '../../domain/entities/todo.dart';
import '../bloc/todo_bloc.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.id),
      background: Container(
        padding: const EdgeInsets.only(right: 25),
        alignment: Alignment.centerRight,
        decoration: const BoxDecoration(color: Colors.red),
        child: const Icon(Icons.delete),
      ),
      onDismissed: (direction) {
        BlocProvider.of<TodoBloc>(context).add(TodoEvent.deleteTodo(todo.id));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: ListTile(
          leading: CustomCheckbox(
            isChecked: todo.isCompleted,
            onChanged: (v) {
              final updatedTodo = todo.copyWith(isCompleted: v);

              context.read<TodoBloc>().add(TodoEvent.updateTodo(updatedTodo));
            },
          ),
          title: Text(
            "${todo.title}\n${todo.description ?? ''}",
            style: TextStyle(
              decoration: todo.isCompleted
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          subtitle:   const Divider(
                          ),
          onTap: onTap,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:todo/presentation/widgets/language_selector.dart';
import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';
import '../bloc/todo_state.dart';
import '../widgets/network_status_widget.dart';
import '../widgets/todo_item.dart';
import 'add_todo_page.dart';
import 'edit_todo_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});


  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).title),
        actions:  [IconButton(onPressed: ()=>context.read<TodoBloc>().add(const TodoEvent.syncTodos()), icon: const Icon(Icons.sync)),const LanguageSelector()],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          context.read<TodoBloc>().add(const TodoEvent.getTodos());
          return Future.value(null);
        },
        child: Column(
          children: [
            const NetworkStatusWidget(),
            Expanded(
              child: BlocBuilder<TodoBloc, TodoState>(
                builder: (context, state) {
                  return state.map(
                    initial: (_) {
                      context.read<TodoBloc>().add(const TodoEvent.getTodos());
                      return const Center(child: CircularProgressIndicator());
                    },
                    loading: (_) => const Center(child: CircularProgressIndicator()),
                    loaded: (state) => state.todos.isNotEmpty
                        ? AnimationLimiter(
                          child: ListView.builder(
                              itemCount: state.todos.length,
                              itemBuilder: (context, index) {
                                final todo = state.todos[index];
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 375),
                                  child:  SlideAnimation(
                                     verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: TodoItem(
                                      todo: todo,
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => EditTodoPage(todo: todo),
                                          ),
                                        );
                                      },
                                      onDelete: () {
                                        context
                                            .read<TodoBloc>()
                                            .add(TodoEvent.deleteTodo(todo.id));
                                      },
                                                                ),
                                    ),
                                  ));
                              },
                            ),
                        )
                        : Center(
                            child: Text(AppLocalizations.of(context).noTodos),
                          ),
                    error: (state) => Center(child: Text(state.message)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 120,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const AddTodoPage()),
            );
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.add), Text("Add item")],
          ),
        ),
      ),
    );
  }
}

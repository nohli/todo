import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/todo/providers/todo_provider.dart';
import 'package:todo/todo/widgets/add_todo_item_widget.dart';
import 'package:todo/todo/widgets/todo_item_widget.dart';

class TodoListWidget extends ConsumerWidget {
  const TodoListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosProvider).todos;
    final provider = ref.read(todosProvider.notifier);
    if (todos.isEmpty) provider.loadTodoList();

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AddTodoItemWidget(provider: provider),
          Expanded(
            child: ReorderableListView.builder(
              padding: const EdgeInsets.fromLTRB(4, 6, 4, 6),
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final id = todos[index].id;

                return TodoItemWidget(
                  todos[index],
                  key: ValueKey(id),
                  onDismissed: () => provider.removeTodo(id),
                  onToggled: () => provider.toggleTodo(id),
                );
              },
              onReorder: provider.reorderTodo,
            ),
          ),
        ],
      ),
    );
  }
}

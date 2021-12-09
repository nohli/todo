import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:todo/todo/providers/todo_provider.dart';
import 'package:todo/todo/widgets/add_todo_item_widget.dart';
import 'package:todo/todo/widgets/todo_item_widget.dart';

class TodoListWidget extends ConsumerWidget {
  const TodoListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosProvider).todos;
    final provider = ref.read(todosProvider.notifier);
    if (todos.isEmpty) provider.getTodoList();

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AddTodoItemWidget(provider: provider),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(4, 6, 4, 6),
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return TodoItemWidget(
                  todos[index],
                  provider: provider,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:todo/common/widgets/dismissible_widget.dart';
import 'package:todo/todo/models/todo_item.dart';
import 'package:todo/todo/providers/todo_provider.dart';

class TodoItemWidget extends StatelessWidget {
  final TodoItem todo;
  final TodosProvider provider;

  const TodoItemWidget(this.todo, {required this.provider, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = todo.id;

    return Card(
      child: DismissibleWidget(
        id: id,
        onDismissed: () => provider.removeTodo(id),
        child: ListTile(
          title: Text(todo.title),
          leading: Checkbox(
            value: todo.completed,
            onChanged: (_) => provider.toggleTodo(id),
          ),
          trailing: const Icon(
            Icons.drag_handle_rounded,
          ),
        ),
      ),
    );
  }
}

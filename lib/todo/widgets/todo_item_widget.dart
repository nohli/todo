import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todo/common/widgets/dismissible_widget.dart';
import 'package:todo/todo/models/todo_item.dart';

class TodoItemWidget extends StatelessWidget {
  final TodoItem todo;
  final VoidCallback onDismissed;
  final VoidCallback onToggled;

  const TodoItemWidget(
    this.todo, {
    required this.onDismissed,
    required this.onToggled,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // ReorderableListView already shows this icon on desktop
    // (see docs of its parameter `buildDefaultDragHandles`)
    final dragHandle = Platform.isIOS || Platform.isAndroid
        ? const Icon(Icons.drag_handle_rounded)
        : const SizedBox();

    return Card(
      child: DismissibleWidget(
        key: key,
        onDismissed: onDismissed,
        child: ListTile(
          onTap: onToggled,
          title: Text(todo.title),
          leading: Checkbox(
            value: todo.isCompleted,
            onChanged: (_) => onToggled(),
          ),
          trailing: dragHandle,
        ),
      ),
    );
  }
}

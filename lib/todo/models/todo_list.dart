import 'dart:convert';

import 'package:todo/todo/models/todo_item.dart';

class TodoList {
  final List<TodoItem> todos;

  TodoList(this.todos);

  factory TodoList.empty() => TodoList([]);

  factory TodoList.fromJson(String json) {
    final todos = <TodoItem>[];
    final list = jsonDecode(json);

    for (final item in list) {
      final todo = TodoItem.fromJson(item);
      todos.add(todo);
    }
    return TodoList(todos);
  }

  String toJson() {
    final list = <Map<String, dynamic>>[];

    for (final todo in todos) {
      list.add(todo.toJson());
    }
    return jsonEncode(list);
  }

  TodoList addTodo(String title) {
    final todo = TodoItem(title: title);
    todos.insert(0, todo);
    return this;
  }

  TodoList removeTodo(int id) {
    todos.removeAt(id - 1);
    return this;
  }

  TodoList toggleTodo(int id) {
    for (final todo in todos) {
      if (todo.id == id) {
        todo.toggle();
        break;
      }
    }
    return this;
  }

  bool get isEmpty => todos.isEmpty;

  bool get isNotEmpty => todos.isNotEmpty;
}

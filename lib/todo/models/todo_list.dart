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
    return TodoList(todos);
  }

  TodoList removeTodo(int id) {
    final index = todos.indexWhere((todo) => todo.id == id);
    todos.removeAt(index);
    return TodoList(todos);
  }

  TodoList toggleTodo(int id) {
    for (final todo in todos) {
      if (todo.id == id) {
        todo.toggle();
        break;
      }
    }
    return TodoList(todos);
  }

  TodoList reorderTodo(int oldIndex, int newIndex) {
    final todo = todos.removeAt(oldIndex);
    if (newIndex > oldIndex) {
      newIndex--;
    }
    todos.insert(newIndex, todo);
    return TodoList(todos);
  }

  bool get isEmpty => todos.isEmpty;

  bool get isNotEmpty => todos.isNotEmpty;
}

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:todo/todo/models/todo_item.dart';

class TodoList {
  final List<TodoItem> todos;

  TodoList(List<TodoItem> todos) : todos = List.unmodifiable(todos);

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

  @useResult
  TodoList addTodo(String title) {
    final todo = TodoItem(title: title);
    return TodoList([todo, ...todos]);
  }

  @useResult
  TodoList removeTodo(int id) {
    final todos = List<TodoItem>.from(this.todos);
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

  @useResult
  TodoList reorderTodo(int oldIndex, int newIndex) {
    final todos = List<TodoItem>.from(this.todos);
    final todo = todos.removeAt(oldIndex);
    if (newIndex > oldIndex) {
      newIndex--;
    }
    todos.insert(newIndex, todo);
    return TodoList(todos);
  }

  @useResult
  TodoList filterList(String text) {
    final filteredTodos = todos.where((todo) => todo.title.contains(text));
    return TodoList(filteredTodos.toList());
  }

  bool get isEmpty => todos.isEmpty;

  bool get isNotEmpty => todos.isNotEmpty;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoList &&
          runtimeType == other.runtimeType &&
          listEquals(todos, other.todos);

  @override
  int get hashCode => todos.hashCode;
}

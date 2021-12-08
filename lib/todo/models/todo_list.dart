import 'package:todo/todo/models/todo_item.dart';

class TodoList {
  List<TodoItem> todos;

  TodoList(this.todos);

  factory TodoList.fromJson(List list) {
    final todos = <TodoItem>[];

    for (final item in list) {
      final todo = TodoItem.fromJson(item);
      todos.add(todo);
    }

    return TodoList(todos);
  }

  List<Map<String, dynamic>> toJson() {
    final list = <Map<String, dynamic>>[];

    for (final todo in todos) {
      list.add(todo.toJson());
    }

    return list;
  }
}
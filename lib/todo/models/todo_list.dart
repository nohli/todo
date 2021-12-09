import 'package:todo/todo/models/todo_item.dart';

class TodoList {
  List<TodoItem> todos;

  TodoList(this.todos);

  static TodoList empty() => TodoList([]);

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

  TodoList addTodoItem(String title) {
    final todo = TodoItem(title: title);
    todos.add(todo);
    return this;
  }

  TodoList removeTodoItem(int id) {
    todos.removeAt(id - 1);
    return this;
  }

  TodoList toggleTodoItem(int id) {
    for (final todo in todos) {
      if (todo.id == id) {
        todo.toggle();
        break;
      }
    }
    return this;
  }

  bool isEmpty() => todos.isEmpty;
}

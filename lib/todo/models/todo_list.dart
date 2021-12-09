import 'package:todo/todo/models/todo_item.dart';

class TodoList {
  final List<TodoItem> todos;

  TodoList(this.todos);

  factory TodoList.empty() => TodoList([]);

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

  bool isEmpty() => todos.isEmpty;
}

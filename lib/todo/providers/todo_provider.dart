import 'package:riverpod/riverpod.dart';

import 'package:todo/todo/models/todo_list.dart';
import 'package:todo/todo/repositories/todo_repository.dart';

final todosProvider = StateNotifierProvider<TodosProvider, TodoList>(
  (ref) {
    return TodosProvider();
  },
);

class TodosProvider extends StateNotifier<TodoList> {
  TodosProvider() : super(TodoList.empty());

  Future<void> getTodos() async {
    state = await TodoRepository.getTodos();
  }

  void addTodo(String title) {
    if (title.isNotEmpty) {
      state = state.addTodoItem(title);
      refreshState();
    }
  }

  void removeTodo(int id) {
    state = state.removeTodoItem(id);
    refreshState();
  }

  void toggleTodo(int id) {
    state = state.toggleTodoItem(id);
    refreshState();
  }

  void refreshState() {
    state = TodoList(state.todos);
  }
}

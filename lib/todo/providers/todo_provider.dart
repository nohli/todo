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

  Future<void> getTodoList() async {
    state = await TodoRepository.getTodoList();
  }

  void addTodo(String title) {
    if (title.isNotEmpty) {
      state = state.addTodo(title);
      refreshState();
    }
  }

  void removeTodo(int id) {
    state = state.removeTodo(id);
    refreshState();
  }

  void toggleTodo(int id) {
    state = state.toggleTodo(id);
    refreshState();
  }

  void refreshState() {
    state = TodoList(state.todos);
  }
}

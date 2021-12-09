import 'package:riverpod/riverpod.dart';

import 'package:todo/todo/models/todo_list.dart';
import 'package:todo/todo/repositories/hive_repository.dart';
import 'package:todo/todo/repositories/todo_repository.dart';

final todosProvider = StateNotifierProvider<TodosProvider, TodoList>(
  (ref) {
    return TodosProvider(
      storage: HiveRepository(),
      repository: TodoRepository(),
    );
  },
);

class TodosProvider extends StateNotifier<TodoList> {
  final HiveRepository storage;
  final TodoRepository repository;

  TodosProvider({required this.storage, required this.repository})
      : super(TodoList.empty());

  Future<void> getTodoList() async {
    final savedList = await storage.load();
    if (savedList.isNotEmpty) {
      state = savedList;
    } else {
      state = await repository.getTodoList();
    }
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
    saveTodoList();
    state = TodoList(state.todos);
  }

  Future<void> loadTodoList() async {
    state = await storage.load();
  }

  Future<void> saveTodoList() async {
    await storage.save(state);
  }
}

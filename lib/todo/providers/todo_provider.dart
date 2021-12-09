import 'package:riverpod/riverpod.dart';

import 'package:todo/todo/models/todo_list.dart';
import 'package:todo/todo/repositories/hive_repository.dart';
import 'package:todo/todo/repositories/placeholder_repository.dart';

final todosProvider = StateNotifierProvider<TodosProvider, TodoList>(
  (ref) {
    return TodosProvider(
      storage: HiveRepository(),
      repository: PlaceholderRepository(),
    );
  },
);

class TodosProvider extends StateNotifier<TodoList> {
  final HiveRepository storage;
  final PlaceholderRepository repository;

  TodosProvider({required this.storage, required this.repository})
      : super(TodoList.empty());

  Future<void> loadTodoList() async {
    final savedList = await storage.load();
    if (savedList.isNotEmpty) {
      state = savedList;
    } else {
      state = await repository.getTodoList();
      _saveTodoList();
    }
  }

  Future<void> _saveTodoList() async {
    await storage.save(state);
    await repository.postTodoList(state);
  }

  void _refreshState() {
    _saveTodoList();
    state = TodoList(state.todos);
  }

  void addTodo(String title) {
    if (title.isNotEmpty) {
      state = state.addTodo(title);
      _refreshState();
    }
  }

  void removeTodo(int id) {
    state = state.removeTodo(id);
    _refreshState();
  }

  void toggleTodo(int id) {
    state = state.toggleTodo(id);
    _refreshState();
  }

  void reorderTodo(int oldIndex, int newIndex) {
    state = state.reorderTodo(oldIndex, newIndex);
    _refreshState();
  }
}

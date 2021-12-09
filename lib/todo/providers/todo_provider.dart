import 'package:http/http.dart';
import 'package:riverpod/riverpod.dart';

import 'package:todo/todo/interfaces/storage_repository.dart';
import 'package:todo/todo/models/todo_list.dart';
import 'package:todo/todo/repositories/hive_repository.dart';
import 'package:todo/todo/repositories/placeholder_repository.dart';

final todosProvider = StateNotifierProvider<TodosProvider, TodoList>(
  (ref) {
    return TodosProvider(
      storage: HiveRepository(),
      repository: PlaceholderRepository(Client()),
    );
  },
);

class TodosProvider extends StateNotifier<TodoList> {
  final StorageRepository storage;
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

  void addTodo(String title) {
    if (title.isNotEmpty) {
      state = state.addTodo(title);
      _saveTodoList();
    }
  }

  void removeTodo(int id) {
    state = state.removeTodo(id);
    _saveTodoList();
  }

  void toggleTodo(int id) {
    state = state.toggleTodo(id);
    _saveTodoList();
  }

  void reorderTodo(int oldIndex, int newIndex) {
    state = state.reorderTodo(oldIndex, newIndex);
    _saveTodoList();
  }
}

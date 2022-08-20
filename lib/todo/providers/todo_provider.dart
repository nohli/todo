import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
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
  final StorageRepository _storage;
  final PlaceholderRepository _repository;

  TodosProvider({required storage, required repository})
      : _storage = storage,
        _repository = repository,
        super(TodoList.empty());

  Future<void> loadTodoList() async {
    final savedList = await _storage.load();
    if (savedList.isNotEmpty) {
      state = savedList;
    } else {
      state = await _repository.getTodoList();
      _saveTodoList();
    }
  }

  Future<void> _saveTodoList() async {
    await _storage.save(state);
    await _repository.postTodoList(state);
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

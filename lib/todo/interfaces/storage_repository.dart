import 'package:todo/todo/models/todo_list.dart';

abstract class StorageRepository {
  Future<TodoList> load();

  Future<void> save(TodoList list);
}

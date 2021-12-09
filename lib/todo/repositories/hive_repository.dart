import 'package:hive/hive.dart';

import 'package:todo/todo/interfaces/storage_repository.dart';
import 'package:todo/todo/models/todo_list.dart';

class HiveRepository implements StorageRepository {
  static const _boxName = 'storage';

  @override
  Future<TodoList> load() async {
    final Box box = await Hive.openBox<String>(_boxName);
    final json = await (box.get('todos') ?? '');
    if (json.isEmpty) {
      return TodoList.empty();
    }
    return TodoList.fromJson(json);
  }

  @override
  Future<void> save(TodoList list) async {
    final Box box = await Hive.openBox<String>(_boxName);
    final json = list.toJson();
    await box.put('todos', json);
  }
}

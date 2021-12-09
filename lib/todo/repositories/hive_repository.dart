import 'package:hive/hive.dart';

import 'package:todo/todo/models/todo_list.dart';

class HiveRepository {
  Future<TodoList> load() async {
    final Box box = await Hive.openBox<String>('storage');
    final json = await (box.get('todos') ?? '');
    if (json.isEmpty) {
      return TodoList.empty();
    }
    return TodoList.fromJson(json);
  }

  Future<void> save(TodoList list) async {
    final Box box = await Hive.openBox<String>('storage');
    final json = list.toJson();
    await box.put('todos', json);
  }
}

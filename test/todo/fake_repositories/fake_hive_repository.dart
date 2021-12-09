import 'package:todo/todo/interfaces/storage_repository.dart';
import 'package:todo/todo/models/todo_list.dart';

class FakeHiveRepository implements StorageRepository {
  final String json;

  const FakeHiveRepository(this.json);

  @override
  Future<TodoList> load() async {
    if (json.isEmpty) {
      return TodoList.empty();
    }
    return TodoList.fromJson(json);
  }

  @override
  Future<void> save(TodoList list) async {}
}

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:todo/todo/models/todo_item.dart';

void main() {
  group('Creates TodoItem', () {
    test('with title only', () {
      const title = 'testTitle';

      final todoItem = TodoItem(
        title: title,
      );

      expect(todoItem.userId, 1);
      expect(todoItem.title, title);
      expect(todoItem.completed, false);
    });

    test('with all arguments', () {
      const userId = 123;
      final id = DateTime.now().millisecondsSinceEpoch - 1;
      const title = 'Long test title with emoji 🎄';
      const completed = true;

      final todoItem = TodoItem(
        userId: userId,
        id: id,
        title: title,
        completed: completed,
      );

      expect(todoItem.userId, userId);
      expect(todoItem.id, id);
      expect(todoItem.title, title);
      expect(todoItem.completed, completed);
    });
  });

  test('Creates TodoItem from Json', () {
    const json =
        '{"userId": 123, "id": 321, "title": "testTitle", "completed": true}';

    final map = jsonDecode(json);
    final todoItem = TodoItem.fromJson(map);

    expect(todoItem.userId, 123);
    expect(todoItem.id, 321);
    expect(todoItem.title, 'testTitle');
    expect(todoItem.completed, true);
  });

  test('Creates Json from TodoItem', () {
    final todoItem = TodoItem(
      userId: 123,
      id: 321,
      title: 'testTitle',
      completed: true,
    );

    const expectedJson =
        '{"userId":123,"id":321,"title":"testTitle","completed":true}';

    final map = todoItem.toJson();
    final json = jsonEncode(map);

    expect(json, expectedJson);
  });

  test('Toggles completed', () {
    final todoItem = TodoItem(
      title: 'testTitle',
    );

    expect(todoItem.completed, false);

    final toggledTodoItem = todoItem.toggle();

    expect(toggledTodoItem.completed, true);
  });
}

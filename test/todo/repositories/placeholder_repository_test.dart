import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:todo/todo/models/todo_item.dart';
import 'package:todo/todo/models/todo_list.dart';
import 'package:todo/todo/repositories/placeholder_repository.dart';

void main() {
  test('Returns correct TodoList', () async {
    const map = [
      {
        'userId': 1,
        'id': 1,
        'title': 'delectus aut autem',
        'completed': false,
      },
      {
        'userId': 1,
        'id': 2,
        'title': 'quis ut nam facilis et officia qui',
        'completed': false,
      },
      {
        'userId': 2,
        'id': 3,
        'title': 'fugiat veniam minus',
        'completed': true,
      }
    ];

    final expectedTodoList = TodoList([
      TodoItem(
        userId: 1,
        id: 1,
        title: 'delectus aut autem',
        completed: false,
      ),
      TodoItem(
        userId: 1,
        id: 2,
        title: 'quis ut nam facilis et officia qui',
        completed: false,
      ),
      TodoItem(
        userId: 2,
        id: 3,
        title: 'fugiat veniam minus',
        completed: true,
      ),
    ]);

    final json = jsonEncode(map);

    final mockClient = MockClient((request) async {
      return Response(json, 200);
    });

    final repository = PlaceholderRepository(mockClient);
    final todoList = await repository.getTodoList();

    expect(todoList, expectedTodoList);
  });

  test('Returns TodoList.empty() if statusCode is not 200', () async {
    final mockClient = MockClient((request) async {
      return Response('{"todos": []}', 201);
    });

    final repository = PlaceholderRepository(mockClient);
    try {
      final todoList = await repository.getTodoList();
      expect(todoList, TodoList.empty());
    } catch (e) {
      expect(e, isA<Exception>());
    }
  });
}

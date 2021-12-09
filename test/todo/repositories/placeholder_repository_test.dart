import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:todo/todo/models/todo_list.dart';
import 'package:todo/todo/repositories/placeholder_repository.dart';

import '../object_mothers/todo_list_mother.dart';

void main() {
  test('Returns correct TodoList', () async {
    const map = TodoListMother.map;
    final expectedTodoList = TodoListMother.todoList;

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

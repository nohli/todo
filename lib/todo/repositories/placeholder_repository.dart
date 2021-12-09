import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:todo/todo/models/todo_list.dart';

class PlaceholderRepository {
  static const _url = 'https://jsonplaceholder.typicode.com/todos';
  final _uri = Uri.parse(_url);

  Future<TodoList> getTodoList() async {
    final response = await http.get(_uri);
    final statusCode = response.statusCode;

    if (statusCode == HttpStatus.ok) {
      return TodoList.fromJson(response.body);
    }

    if (kDebugMode) {
      throw Exception(
        'Failed to load todo list from api. Statuscode: $statusCode',
      );
    }
    return TodoList.empty();
  }

  Future<void> postTodoList(TodoList list) async {
    final response = await http.post(
      _uri,
      body: list.toJson(),
    );

    final statusCode = response.statusCode;

    if (statusCode == HttpStatus.created) {
      return;
    }
    if (kDebugMode) {
      throw Exception(
        'Failed to send todo list to api. Statuscode: $statusCode',
      );
    }
  }
}

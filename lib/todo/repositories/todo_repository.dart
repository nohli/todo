import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:todo/todo/models/todo_list.dart';

class TodoRepository {
  static Future<TodoList> getTodos() async {
    const url = 'https://jsonplaceholder.typicode.com/todos';

    final response = await http.get(Uri.parse(url));
    final statusCode = response.statusCode;

    if (statusCode == HttpStatus.ok) {
      final list = jsonDecode(response.body);
      final TodoList todos = TodoList.fromJson(list);
      return todos;
    } else {
      return TodoList.empty();
    }
  }
}

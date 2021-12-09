import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:todo/todo/models/todo_list.dart';

class PlaceholderRepository {
  Future<TodoList> getTodoList() async {
    const url = 'https://jsonplaceholder.typicode.com/todos';

    final response = await http.get(Uri.parse(url));
    final statusCode = response.statusCode;

    if (statusCode == HttpStatus.ok) {
      return TodoList.fromJson(response.body);
    }

    return TodoList.empty();
  }
}

import 'dart:convert';

import 'package:todo/todo/models/todo_item.dart';
import 'package:todo/todo/models/todo_list.dart';

class TodoListMother {
  static final json = jsonEncode(
    [
      {
        'userId': 1,
        'id': 1,
        'title': 'delectus aut autem',
        'isCompleted': false,
      },
      {
        'userId': 1,
        'id': 2,
        'title': 'quis ut nam facilis et officia qui',
        'isCompleted': false,
      },
      {
        'userId': 2,
        'id': 3,
        'title': 'fugiat veniam minus',
        'isCompleted': true,
      }
    ],
  );

  static final todoList = TodoList(
    [
      TodoItem(
        userId: 1,
        id: 1,
        title: 'delectus aut autem',
        isCompleted: false,
      ),
      TodoItem(
        userId: 1,
        id: 2,
        title: 'quis ut nam facilis et officia qui',
        isCompleted: false,
      ),
      TodoItem(
        userId: 2,
        id: 3,
        title: 'fugiat veniam minus',
        isCompleted: true,
      ),
    ],
  );
}

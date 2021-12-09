import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

import 'package:todo/main.dart';
import 'package:todo/todo/models/todo_list.dart';
import 'package:todo/todo/providers/todo_provider.dart';
import 'package:todo/todo/repositories/placeholder_repository.dart';
import 'package:todo/todo/widgets/todo_list_widget.dart';

import '../fake_repositories/fake_hive_repository.dart';
import '../object_mothers/todo_list_mother.dart';

void main() {
  late TodoList expectedTodoList;
  late Widget widget;

  setUp(() async {
    const map = TodoListMother.map;
    expectedTodoList = TodoListMother.todoList;

    final json = jsonEncode(map);

    final mockClient = MockClient((request) async {
      return Response(json, 200);
    });

    final providerOverride = TodosProvider(
      storage: FakeHiveRepository(json),
      repository: PlaceholderRepository(mockClient),
    );

    widget = ProviderScope(
      overrides: [
        todosProvider.overrideWithValue(providerOverride),
      ],
      child: MaterialApp(
        home: Material(
          child: Consumer(
            builder: (_, ref, __) {
              final provider = ref.read(todosProvider.notifier);
              provider.loadTodoList();

              return const MyHomePage();
            },
          ),
        ),
      ),
    );
  });
  testWidgets(
      'Provider loads TodoList from repository, widget displays first entry',
      (tester) async {
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    expect(find.byType(TodoListWidget), findsOneWidget);

    expect(find.text(expectedTodoList.todos.first.title), findsOneWidget);
  });
}

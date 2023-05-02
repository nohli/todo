import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:todo/main.dart';
import 'package:todo/todo/providers/todos_provider.dart';
import 'package:todo/todo/repositories/placeholder_repository.dart';
import 'package:todo/todo/widgets/todo_list_widget.dart';

import '../fake_repositories/fake_hive_repository.dart';
import '../object_mothers/todo_list_mother.dart';

void main() {
  final json = TodoListMother.json;
  final expectedTodoList = TodoListMother.todoList;

  final mockClient = MockClient(
    (request) async {
      switch (request.method) {
        case 'GET':
          return Response(json, 200);
        case 'POST':
          return Response('', 201);
        default:
          return Response('', 400);
      }
    },
  );

  testWidgets(
      'Provider loads TodoList from storage, widget displays first entry',
      (tester) async {
    final notifier = TodosProvider(
      storage: FakeHiveRepository(json),
      repository: PlaceholderRepository(mockClient),
    );

    final widget = ProviderScope(
      overrides: [
        todosProvider.overrideWith((ref) => notifier),
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

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    expect(find.byType(TodoListWidget), findsOneWidget);

    expect(find.text(expectedTodoList.todos.first.title), findsOneWidget);
  });

  testWidgets(
      'Provider loads TodoList from repository, widget displays first entry',
      (tester) async {
    final notifier = TodosProvider(
      storage: FakeHiveRepository(json),
      repository: PlaceholderRepository(mockClient),
    );

    final widget = ProviderScope(
      overrides: [
        todosProvider.overrideWith((ref) => notifier),
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

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    expect(find.byType(TodoListWidget), findsOneWidget);

    expect(find.text(expectedTodoList.todos.first.title), findsOneWidget);
  });
}

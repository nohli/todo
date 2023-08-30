import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:todo/main.dart';
import 'package:todo/todo/providers/todos_provider.dart';
import 'package:todo/todo/repositories/placeholder_repository.dart';
import 'package:todo/todo/widgets/todo_item_widget.dart';

import '../fake_repositories/fake_hive_repository.dart';

void main() {
  late TodosNotifier notifier;
  late Widget widget;

  final json = jsonEncode([]);
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

  setUp(() {
    notifier = TodosNotifier(
      storage: FakeHiveRepository(json),
      repository: PlaceholderRepository(mockClient),
    );

    widget = ProviderScope(
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
  });

  testWidgets('add item', (tester) async {
    await tester.pumpWidget(widget);
    await tester.enterText(find.byType(TextField), 'new_todo');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    final addedItem = find.descendant(
      of: find.byType(TodoItemWidget),
      matching: find.text('new_todo'),
    );
    expect(addedItem, findsOneWidget);
  });

  testWidgets('new item is added at the top of the list', (tester) async {
    await tester.pumpWidget(widget);

    await tester.enterText(find.byType(TextField), 'todo1');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'todo2');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    expect(find.byType(TodoItemWidget), findsNWidgets(2));

    final text1 = find.descendant(
      of: find.byType(TodoItemWidget),
      matching: find.text('todo1'),
    );
    final text2 = find.descendant(
      of: find.byType(TodoItemWidget),
      matching: find.text('todo2'),
    );

    final text1Position = tester.getTopLeft(text1);
    final text2Position = tester.getTopLeft(text2);

    // text2 should be on top, because it was added last
    expect(text1Position.dy, greaterThan(text2Position.dy));
  });

  testWidgets('toggle item by clicking checkbox', (tester) async {
    await tester.pumpWidget(widget);
    await tester.enterText(find.byType(TextField), 'todo1');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    final addedItem = find.descendant(
      of: find.byType(TodoItemWidget),
      matching: find.text('todo1'),
    );
    expect(addedItem, findsOneWidget);

    final checkBox = find.descendant(
      of: find.byType(TodoItemWidget),
      matching: find.byType(Checkbox),
    );

    expect((checkBox.evaluate().first.widget as Checkbox).value, false);

    await tester.tap(checkBox);
    await tester.pumpAndSettle();

    expect((checkBox.evaluate().first.widget as Checkbox).value, true);
  });

  testWidgets('toggle item by clicking item', (tester) async {
    final notifier = TodosNotifier(
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
    await tester.enterText(find.byType(TextField), 'todo1');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    final addedItem = find.descendant(
      of: find.byType(TodoItemWidget),
      matching: find.text('todo1'),
    );
    expect(addedItem, findsOneWidget);

    final checkBox = find.descendant(
      of: find.byType(TodoItemWidget),
      matching: find.byType(Checkbox),
    );

    expect((checkBox.evaluate().first.widget as Checkbox).value, false);

    await tester.tap(addedItem);
    await tester.pumpAndSettle();

    expect((checkBox.evaluate().first.widget as Checkbox).value, true);
  });
}

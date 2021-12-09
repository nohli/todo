import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:todo/todo/models/todo_item.dart';
import 'package:todo/todo/widgets/todo_item_widget.dart';

void main() {
  testWidgets('Displays ListTile correctly', (tester) async {
    final todoItem = TodoItem(
      userId: 123,
      id: 321,
      title: 'Todo Item',
      completed: true,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: TodoItemWidget(
            todoItem,
            onDismissed: () {},
            onToggled: () {},
          ),
        ),
      ),
    );

    expect(find.text(todoItem.title), findsOneWidget);
    expect(find.byIcon(Icons.drag_handle_rounded), findsOneWidget);

    final finder = find.byType(Checkbox);
    expect(finder, findsOneWidget);

    final checkbox = tester.firstWidget(finder) as Checkbox;
    expect(checkbox.value, todoItem.completed);
  });

  (testWidgets('VoidCallback onToggled works', (tester) async {
    final todoItem = TodoItem(
      userId: 123,
      id: 321,
      title: 'Todo Item',
      completed: false,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: TodoItemWidget(
            todoItem,
            onDismissed: () {},
            onToggled: () => todoItem.completed = !todoItem.completed,
          ),
        ),
      ),
    );

    final finder = find.byType(Checkbox);
    final checkbox = tester.firstWidget(finder) as Checkbox;
    expect(checkbox.value, todoItem.completed);

    await tester.tap(finder);
    await tester.pumpAndSettle();

    final tappedCheckbox = tester.firstWidget(finder) as Checkbox;
    expect(tappedCheckbox.value, !todoItem.completed);
  }));
}

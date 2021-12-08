import 'package:flutter_test/flutter_test.dart';

import 'package:todo/main.dart';

void main() {
  testWidgets('Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
  });
}

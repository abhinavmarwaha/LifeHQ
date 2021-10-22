import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lifehq/main.dart';

void main() {
  testWidgets('demo', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    await tester.tap(find.byIcon(Icons.arrow_forward_ios));
    await tester.pump();

    expect('', '');
  });
}

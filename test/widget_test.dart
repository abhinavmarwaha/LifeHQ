import 'package:flutter_test/flutter_test.dart';

import 'package:lifehq/main.dart';

void main() {
  testWidgets('demo', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(true, true);
  });
}

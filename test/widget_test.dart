import 'package:flutter_test/flutter_test.dart';

import 'package:dojo_flutter/main.dart';

void main() {
  testWidgets('example', (WidgetTester tester) async {
    await tester.pumpWidget(const TmdbApp());
  });
}
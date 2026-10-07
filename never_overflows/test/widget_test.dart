import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:never_overflows/main.dart';

void main() {
  testWidgets('Contact list renders without overflow on a phone', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MyApp());

    expect(find.text('Contacts'), findsOneWidget);
    expect(find.text('20 contacts'), findsOneWidget);
    expect(find.text('Aida Akhmetova'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

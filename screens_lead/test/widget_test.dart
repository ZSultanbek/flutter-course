import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:screens_lead/main.dart';

void main() {
  testWidgets('List → detail → edit, with back, discard and save', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Students'), findsOneWidget);
    expect(find.byType(BackButton), findsNothing);

    // List → detail: AppBar draws the back arrow on its own.
    await tester.tap(find.text('Aida Akhmetova'));
    await tester.pumpAndSettle();
    expect(find.text('aida@kbtu.kz'), findsOneWidget);
    expect(find.byType(BackButton), findsOneWidget);

    // Clean form: back leaves without a dialog, nothing changes.
    await tester.tap(find.byIcon(Icons.edit));
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Discard changes?'), findsNothing);
    expect(find.text('aida@kbtu.kz'), findsOneWidget);

    // Dirty form: back asks; Keep editing stays, Discard leaves.
    await tester.tap(find.byIcon(Icons.edit));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'A');
    await tester.pump();
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Discard changes?'), findsOneWidget);
    await tester.tap(find.text('Keep editing'));
    await tester.pumpAndSettle();
    expect(find.byType(TextField), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Discard'));
    await tester.pumpAndSettle();
    expect(find.byType(TextField), findsNothing);
    expect(find.text('Aida Akhmetova'), findsOneWidget);

    // Save: no dialog, the new name comes back to the detail screen.
    await tester.tap(find.byIcon(Icons.edit));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Aida K');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.text('Discard changes?'), findsNothing);
    expect(find.text('Aida K'), findsOneWidget);

    // Back to the list, which was waiting underneath.
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Students'), findsOneWidget);
  });
}

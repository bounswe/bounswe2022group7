import 'package:android/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Create event pages input fields are correct',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: CreateEvent()));

    // test input fields
    expect(find.text('Event Category'), findsOneWidget);
    expect(find.text('Title'), findsOneWidget);
    expect(find.text('Description'), findsOneWidget);
    expect(find.text('Start Date'), findsOneWidget);
    expect(find.text('End Date'), findsOneWidget);
    expect(find.text('Categories'), findsOneWidget);
    expect(find.text('Price'), findsOneWidget);
    expect(find.text('Labels'), findsOneWidget);

    // test buttons
    expect(find.text('Select Poster'), findsOneWidget);
    expect(find.text('Select Event Location'), findsOneWidget);
    expect(find.text('Create'), findsOneWidget);
  });
}

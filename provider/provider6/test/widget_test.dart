// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:provider6/json/events.dart';

void main() {

  testWidgets('Test load', (WidgetTester tester) async {
    final file = new File('assets/events.json');

    final json = jsonDecode(await file.readAsString());
    Events events = Events.fromJson(json);

    // Verify data has been read.
    expect(events, isNotNull);
  });
}

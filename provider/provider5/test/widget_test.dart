// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';


import '../lib/headlines.dart';
import '../lib/model.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    NewsModel newsModel = NewsModel();

    await newsModel.updateHeadlines();

    Headlines headlines = newsModel.headlines as Headlines;

    // Verify that our counter has incremented.
    expect(headlines, isNotEmpty);
  });
}

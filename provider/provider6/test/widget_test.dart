// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:provider6/model.dart';
import 'package:provider6/news.dart';


const String USERS = '{"status":"ok","totalResults":38,"articles":[{"source":{"id":null,"name":"Elevenwarriors.com"},"author":null,"title":"Mark Dantonio Stepping Down As Michigan States Head Coach After 13 Seasons | Eleven Warriors - Eleven Warriors","description":"Mark Dantonio announced Tuesday that he will step down as Michigan States head coach following 13 seasons with the Spartans.","url":"https://www.elevenwarriors.com/the-big-ten/2020/02/111987/mark-dantonio-stepping-down-as-michigan-states-head-coach-after-13-seasons","urlToImage":"https://www.elevenwarriors.com/sites/default/files/styles/904x490/public/c/2020/02/111987_h.jpg?itok=pYrkcaQk","publishedAt":"2020-02-04T19:54:31Z","content":"Mark Dantonios tenure as Michigan States head coach has come to an end. \r\nAfter 13 years leading Michigan States football program, Dantonio announced Tuesday that he has decided to step down as the Spartans head coach.\r\nTo all Spartans: Thank you for ever"}]}';

void main() {

  testWidgets('Test load', (WidgetTester tester) async {
    NewsModel newsModel = NewsModel();

    News news  = newsModel.decodeNews(escape(USERS));

    // Verify data has been read.
    expect(news, isNotNull);
  });
}

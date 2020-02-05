import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider5/model.dart';
import 'package:flutter/cupertino.dart';


void main() => runApp(NewsApp());

class NewsApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
        providers: [
          FutureProvider(create: (context) => NewsModel().updateHeadlines()),
        ],
        child: HeadlinesPage(title: 'News List'),
      )
    );
  }
}

class HeadlinesPage extends StatefulWidget {
  HeadlinesPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HeadlinesPageState createState() => _HeadlinesPageState();
}

class _HeadlinesPageState extends State<HeadlinesPage> {
  @override
  Widget build(BuildContext context) {

    NewsModel _newsModel = Provider.of<NewsModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
                child: _newsModel.headlines == null ? Container(child: CupertinoActivityIndicator(radius: 50.0)) :
                ListView.builder(
                    itemCount: _newsModel.headlines.articles.length,
                    itemBuilder: (context, index){
                      return Container(
                          height: 50,
                          color: Colors.grey[(index*200) % 400],
                          child: Center(
                              child: Text(
                                  '${ _newsModel.headlines.articles[index].title}'
                              )
                          )
                      );
                    }
                )
            )
          ],
        ),
      ),
    );
  }
}

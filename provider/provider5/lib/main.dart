import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider5/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider5/news.dart';


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

    News _news = Provider.of<News>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
                child: _news == null ? Container(child: CupertinoActivityIndicator(radius: 50.0)) :
                ListView.builder(
                    itemCount: _news.articles.length,
                    itemBuilder: (context, index){
                      return Card(
                        child: ListTile(
                          leading: FlutterLogo(size: 56.0),
                          title: Text('${ _news.articles[index].title}'),
                          subtitle: Text('${ _news.articles[index].description}'),
                          trailing: Icon(Icons.more_vert),
                        ),
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

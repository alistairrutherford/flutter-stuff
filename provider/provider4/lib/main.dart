import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider4/providers.dart';
import 'package:provider4/user.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
        providers: [
           FutureProvider(create: (context) => UserProvider().loadUserData(),), 
        ],
        child: MyHomePage(title: 'Flutter Demo Home Page'),
      )
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
    var _users = Provider.of<List<User>>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
                child: _users == null ? Container(child: CupertinoActivityIndicator(radius: 50.0)) :
                ListView.builder(
                    itemCount: _users.length,
                    itemBuilder: (context, index){
                      return Container(
                          height: 50,
                          color: Colors.grey[(index*200) % 400],
                          child: Center(
                              child: Text(
                                  '${_users[index].firstName} ${_users[index].lastName} | ${_users[index].website}'
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

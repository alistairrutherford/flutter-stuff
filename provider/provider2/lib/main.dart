import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyModel extends ChangeNotifier {
  static const String HELLO = "Hello";
  static const String GOODBYE = "Goodbye";

  String someValue = HELLO;

  void doSomething() {
    if (someValue == HELLO) {
      someValue = GOODBYE;
    } else  {
      someValue = HELLO;
    }

    notifyListeners();
  }
}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myModel = Provider.of<MyModel>(context, listen:false);

    return RaisedButton(onPressed: () {
        myModel.doSomething();
    });
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
    return ChangeNotifierProvider<MyModel> (
      create : (context) => MyModel(), // Create model instance
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: MyButton()
            ),
            Container(
              child: Consumer<MyModel>(
                builder: (context, value, child) {
                  return Text(value.someValue);
                },
              )
            ),
          ]
        ) 
      )
    );
  }
}

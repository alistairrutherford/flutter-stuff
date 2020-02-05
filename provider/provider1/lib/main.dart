import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyModel with ChangeNotifier{
  static const String HELLO = 'Hello';
  static const String GOODBYE = 'Goodbye';

  String someValue = HELLO;

  void doSomething() {
    if (someValue == HELLO) {
      someValue = GOODBYE;
    } else {
      someValue = HELLO;
    }
    
    print(someValue);
    notifyListeners();
  }
}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myModel = Provider.of<MyModel>(context, listen: false);

    return  RaisedButton(
      child: Text('Do Something'),
      onPressed: () {
        /* Do something */
        myModel.doSomething();
      },
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyModel>(
      create :(context) => MyModel(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(title: Text('Provider - Sample 1')),
          body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20),
                color: Colors.green,
                child: MyButton()
              ),
              Container(
                padding: const EdgeInsets.all(36),
                color: Colors.blue,
                child: Consumer<MyModel>(
                  builder: (context, myModel, child)  {
                    return Text(myModel.someValue);
                  },
                ),
              )
            ],
          ),
        )
      )
    );
  }
}


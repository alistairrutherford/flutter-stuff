import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models.dart';


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
      home: MyHomePage(title: 'Future Provider'),
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureProvider<LimitOrderModel>(
        initialData: LimitOrderModel(),
        create: (context) => loadAsyncModel(),
        child: Consumer<LimitOrderModel>(
          builder: (context, myModel, child) {
            int size = myModel.orders.length;
            return Text('Size $size');
          },
        ),
      ),
    );
  }
}

// Asynv load of model
Future<LimitOrderModel> loadAsyncModel() async {
  LimitOrderModel model = LimitOrderModel();
  model.fetchOrders();
  return model;
}
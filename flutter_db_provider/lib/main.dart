import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_db_provider/location_model.dart';
import 'package:flutter_db_provider/timer_model.dart';
import 'package:provider/provider.dart';
import 'main_page.dart';
import 'journey_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Ensure portrait orientation only.
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: JourneyModel(),
        ),
        ChangeNotifierProvider.value(
          value: LocationModel(),
        ),
        ChangeNotifierProvider.value(value: TimerModel())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const MainAppView(),
      ),
    );
  }
}

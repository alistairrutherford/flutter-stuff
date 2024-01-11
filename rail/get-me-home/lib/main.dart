import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_me_home/model/timetable_model.dart';
import 'package:provider/provider.dart';
import 'arrivalsdepartures.dart';
import 'model/network_model.dart';
import 'model/prefs_model.dart';

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
          value: SharedPreferencesModel(),
        ),
        ChangeNotifierProvider.value(
          value: NetworkModel(),
        ),
        ChangeNotifierProvider.value(
          value: TimeTableModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Get Me Home',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const ArrivalsDeparturesView(),
      ),
    );
  }
}

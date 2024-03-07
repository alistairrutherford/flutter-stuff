import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_me_home/model/stations_model.dart';
import 'package:get_me_home/model/timetable_model.dart';
import 'package:provider/provider.dart';
import 'arrivals_departures.dart';
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
        ChangeNotifierProvider.value(
          value: StationsModel(),
        ),
      ],
      child: const MainView(),
    );
  }
}

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  @override
  Widget build(BuildContext context) {
    var stationsModel = context.watch<StationsModel>();

    return MaterialApp(
      title: 'Get Me Home',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        )),
      ),
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Text('Next Train'),
          ),
          body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchAnchor(
                  builder: (BuildContext context, SearchController controller) {
                return SearchBar(
                  controller: controller,
                  padding: const MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 16.0)),
                  onTap: () {
                    controller.openView();
                  },
                  onChanged: (_) {
                    controller.openView();
                  },
                  leading: const Icon(Icons.search),
                );
              }, suggestionsBuilder:
                      (BuildContext context, SearchController controller) {
                return List<ListTile>.generate(stationsModel.stationsCount(stationsModel), (int index) {
                  final String item = stationsModel.getStationName(index);
                  return ListTile(
                    title: Text(item),
                    onTap: () {
                      setState(() {
                        controller.closeView(item);
                      });
                    },
                  );
                });
              }),
            ),
            const Expanded(
              child: ArrivalsDeparturesView(),
            ),
          ])),
    );
  }
}

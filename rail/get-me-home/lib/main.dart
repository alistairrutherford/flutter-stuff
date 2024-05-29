import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_me_home/model/stations_model.dart';
import 'package:get_me_home/model/timetable_model.dart';
import 'package:provider/provider.dart';
import 'arrivals_departures.dart';
import 'dao/stations.dart';
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

class IconLabel {
  const IconLabel(this.label, this.icon);
  final String label;
  final IconData icon;
}

class _MainViewState extends State<MainView> {
  final TextEditingController iconController = TextEditingController();
  IconLabel? selectedIcon;

  /// Build dropdown list.
  List<DropdownMenuEntry<IconLabel>> buildStations(StationsModel model) {
    List<Station?>? stations = List<Station>.empty(growable: true);
    List<DropdownMenuEntry<IconLabel>> dropdownStations = List<DropdownMenuEntry<IconLabel>>.empty(growable: true);

     if (model.stations != null) {
       if (model.stations!.stationsReferenceData != null) {
         if (model.stations!.stationsReferenceData!.station != null) {
           stations = model.stations!.stationsReferenceData!.station;

           for (final station in stations!) {
             String name = station!.name!;
             IconLabel iconLabel = IconLabel(name, Icons.favorite);

             DropdownMenuEntry<IconLabel> entry = DropdownMenuEntry<IconLabel>(value: iconLabel, label: name);

             dropdownStations.add(entry);
           }
         }
        }
     }

     return dropdownStations;
  }

  @override
  Widget build(BuildContext context) {
    var stationsModel = context.watch<StationsModel>();
    List<DropdownMenuEntry<IconLabel>> dropdownMenuEntries = buildStations(stationsModel);

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
              child:
              DropdownMenu<IconLabel>(
                controller: iconController,
                enableFilter: true,
                requestFocusOnTap: true,
                leadingIcon: const Icon(Icons.search),
                label: const Text('Icon'),
                inputDecorationTheme: const InputDecorationTheme(
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                ),
                onSelected: (IconLabel? icon) {
                  setState(() {
                    selectedIcon = icon;
                  });
                },
                dropdownMenuEntries: dropdownMenuEntries.toList(),
              ),
            ),
            const Expanded(
              child: ArrivalsDeparturesView(),
            ),
          ])),
    );
  }
}

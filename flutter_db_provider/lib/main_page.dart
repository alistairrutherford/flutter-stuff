import 'package:flutter/material.dart';
import 'package:flutter_db_provider/journey_rec_page.dart';
import 'journey_list_page.dart';

class MainAppView extends StatelessWidget {
  const MainAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TabMainView());
  }
}

class TabMainView extends StatefulWidget {
  const TabMainView({super.key});

  @override
  State<TabMainView> createState() => _TabMainViewState();
}

class _TabMainViewState extends State<TabMainView> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Journey Recorder'),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber[800],
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.directions_bike),
            icon: Icon(Icons.directions_bike_outlined),
            label: 'Record',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.info),
            icon: Icon(Icons.info_outline),
            label: 'About',
          ),
        ],
      ),
      body: <Widget>[
        Container(
          alignment: Alignment.center,
          child: const JourneyListView(),
        ),
        Container(
          alignment: Alignment.center,
          child: JourneyRecordView(),
        ),
        Container(
          alignment: Alignment.center,
          child: const Text('About'),
        ),
      ][currentPageIndex],
    );
  }
}

import 'package:flutter/material.dart';
import 'journey_page.dart';

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
      appBar: AppBar(title: Text('Journey Recorder'),
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
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.school),
            icon: Icon(Icons.school_outlined),
            label: 'School',
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
          child: const Text('Page 2'),
        ),
        Container(
          alignment: Alignment.center,
          child: const Text('Page 3'),
        ),
      ][currentPageIndex],
    );
  }
}

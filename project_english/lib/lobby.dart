import 'package:flutter/material.dart';
import 'package:project_english/advices.dart';
import 'agile.dart';
import 'scrum.dart';
import 'waterfall.dart';

class LobbyPage extends StatefulWidget {
  @override
  _LobbyPageState createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {
  int _selectedIndex = -1;

  static List<Widget> _widgetOptions = <Widget>[
    AgileInfoPage(),
    scrumInfoPage(),
    waterfallInfoPage(),
    Advices(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedIndex == -1
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Image.asset(
                        'images/main.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Image.asset(
                        'images/logo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: _selectedIndex == -1
                          ? Text('Select an option from the bottom bar')
                          : _widgetOptions.elementAt(_selectedIndex),
                    ),
                  ),
                ],
              ),
            )
          : _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_graph_outlined),
            label: 'Agile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Scrum',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Waterfall',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.emergency_recording_sharp), label: 'Advices'),
        ],
        currentIndex: _selectedIndex == -1 ? 0 : _selectedIndex,
        selectedItemColor: Colors.orange[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        showUnselectedLabels: true,
      ),
    );
  }
}

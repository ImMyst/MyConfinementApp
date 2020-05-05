import 'package:flutter/material.dart';
import 'package:my_confinement/pages/agenda.dart';
import 'package:my_confinement/pages/compass.dart';
import 'package:my_confinement/pages/home.dart';
import 'package:my_confinement/pages/map.dart';

import './pages/todolist.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
      title: 'My Confinement',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.teal,
      ),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 2;

  List _pages = [
    new ToDoListPage(),
    new MapPage(),
    new HomePage(),
    new CompassPage(),
    new AgendaPage()
  ];

  List _titles = [
    'ToDo List',
    'Carte',
    'My Confinement',
    'Boussole',
    'Agenda',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.teal[200],
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Colors.teal[400],
              icon: Icon(Icons.format_list_bulleted),
              title: Text('ToDo List'),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.teal[400],
              icon: Icon(Icons.gps_fixed),
              title: Text('Carte'),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.teal[400],
              icon: Icon(Icons.home),
              title: Text('Accueil'),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.teal[400],
              icon: Icon(Icons.explore),
              title: Text('Boussole'),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.teal[400],
              icon: Icon(Icons.today),
              title: Text('Agenda'),
            ),
          ]),
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
      ),
      body: Center(
        child: _pages[_currentIndex],
      ),
    );
  }
}

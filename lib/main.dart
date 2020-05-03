import 'package:flutter/material.dart';

// Pages import

import './pages/agenda.dart';
import './pages/compass.dart';
import './pages/map.dart';
import './pages/todolist.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Confinement',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'My Confinement'),
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
      drawer: Drawer(
        child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('My Confinement'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.format_list_bulleted),
            title: Text('ToDo List'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, new MaterialPageRoute(
                builder: (BuildContext context) => new ToDoListPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.gps_fixed),
            title: Text('Carte'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, new MaterialPageRoute(
                builder: (BuildContext context) => new MapPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.explore),
            title: Text('Boussole'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, new MaterialPageRoute(
                builder: (BuildContext context) => new CompassPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.today),
            title: Text('Agenda'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, new MaterialPageRoute(
                builder: (BuildContext context) => new AgendaPage()));
            },
          ),
        ],
      ),
      ),
      appBar: AppBar(
        title: Text(widget.title),
      ),
    );
  }
}

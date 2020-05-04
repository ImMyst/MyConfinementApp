import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(15),
            width: double.infinity,
            child: Card(
              elevation: 4,
              color: Colors.teal[100],
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Column(children: <Widget>[
                Image.asset(
                  'images/embedImage.jpeg',
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Text(
                    'My Confinement',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Text(
                        "L'application pour ne pas s'ennuyer pendant le confinement 🦠",
                        style: TextStyle(fontSize: 27),
                        textAlign: TextAlign.center)),
              ]),
            )));
  }
}

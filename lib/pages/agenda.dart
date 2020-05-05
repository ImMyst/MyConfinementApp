import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.blue,
          accentColor: Colors.green),
      home: AgendaPage(),
    ));

class AgendaPage extends StatefulWidget {
  @override
  _AgendaPageState createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  String agendaEventTitle = "";
  File agendaEventImage = new File('');
  DateTime agendaDate = new DateTime.now();
  String agendaEventLocation = "";

  createAgendaEvent() {
    DocumentReference documentReference =
        Firestore.instance.collection("AgendaEvent").document(agendaEventTitle);

    //Map
    Map<String, String> agendaEventTitles = {"agendaTitle": agendaEventTitle};

    documentReference.setData(agendaEventTitles).whenComplete(() {
      print("$agendaEventTitle créé");
    });
  }

  deleteAgendaEvent(item) {
    DocumentReference documentReference =
        Firestore.instance.collection("agendaEvent").document(item);

    documentReference.delete().whenComplete(() {
      print("$item supprimé");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  title: Text("Ajouter un évenement"),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        TextField(
                          onChanged: (String value) {
                            agendaEventTitle = value;
                          },
                        ),
                        TextField(onChanged: (String value) {
                          agendaEventLocation = value;
                        })
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          createAgendaEvent();
                          Navigator.of(context).pop();
                        },
                        child: Text("Ajouter"))
                  ],
                );
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection("agendaEvent").snapshots(),
          builder: (context, snapshots) {
            if (snapshots.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshots.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentSnapshot =
                        snapshots.data.documents[index];
                    return Dismissible(
                        onDismissed: (direction) {
                          deleteAgendaEvent(documentSnapshot["agendaTitle"]);
                        },
                        key: Key(documentSnapshot["agendaTitle"]),
                        child: Card(
                          child: Container(
                            child: ListTile(
                              title: Text(documentSnapshot["agendaTitle"]),
                              trailing: IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    deleteAgendaEvent(
                                        documentSnapshot["agendaTitle"]);
                                  }),
                              subtitle:
                                  Text(documentSnapshot["agendaLocation"]),
                            ),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('images/embedImage.jpeg'),
                                    fit: BoxFit.fitWidth,
                                    alignment: Alignment.topCenter)),
                          ),
                          elevation: 4,
                          margin: EdgeInsets.all(8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ));
                  });
            } else {
              return Align(
                alignment: FractionalOffset.bottomCenter,
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

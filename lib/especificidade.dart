import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plantground/receitas_possiveis.dart';

void main() {
  runApp(MaterialApp(
    title: 'Especificidade',
    debugShowCheckedModeBanner: false,
  ));
}

class Especificidade extends StatefulWidget {
  final idCarac;
  Especificidade(this.idCarac);
  @override
  _EspecificidadeState createState() => _EspecificidadeState(idCarac);
}

class _EspecificidadeState extends State<Especificidade> {
  final idCarac2;
  _EspecificidadeState(this.idCarac2);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          title: Text(idCarac2, style: TextStyle(color: Colors.white)),
          centerTitle: true,
          elevation:
              Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: StreamBuilder(
                    stream: Firestore.instance
                        .collection("especificidade")
                        .snapshots(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        default:
                          return ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              Widget a;
                              snapshot.data.documents[index]
                                          .data["nome$idCarac2"] !=
                                      null
                                  ? a = TextReceitas(
                                      snapshot.data.documents[index].data,
                                      idCarac2)
                                  : a = null;
                              return a;
                            },
                          );
                      }
                    }),
              ),
              Container(
                color: Colors.greenAccent,
                margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PossiveisReceitas(idCarac2)));
                            },
                            child: Text(
                              "Receitas",
                              style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                      ),
                    ]),
              )
            ]),
      ),
    );
  }
}

class TextEspecificidade extends StatelessWidget {
  final Map<String, dynamic> data;
  final idCarac3;

  TextEspecificidade(this.data, this.idCarac3);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin:
            EdgeInsets.only(top: 100.0, bottom: 50.0, left: 20.0, right: 20.0),
        child: Text(
          data["nome$idCarac3"],
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24.0, color: Colors.black),
        ));
  }
}

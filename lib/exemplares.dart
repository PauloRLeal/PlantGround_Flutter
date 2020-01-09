import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plantground/especificidade.dart';

void main() {
  runApp(MaterialApp(
    title: 'Exemplares',
    debugShowCheckedModeBanner: false,
  ));
}

class Exemplares extends StatefulWidget {
  final idCarac;
  Exemplares(this.idCarac);
  @override
  _Exemplares createState() => _Exemplares(idCarac);
}

class _Exemplares extends State<Exemplares> {
  final idCarac2;
  _Exemplares(this.idCarac2);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          title: Text(idCarac2),
          centerTitle: true,
          elevation:
              Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: StreamBuilder(
                stream: Firestore.instance.collection("exemplares").snapshots(),
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
                          return TextCaracteristicas(
                              snapshot.data.documents[index].data, idCarac2);
                        },
                      );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TextCaracteristicas extends StatelessWidget {
  final Map<String, dynamic> data;
  final idCarac3;

  TextCaracteristicas(this.data, this.idCarac3);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 60.0, left: 7.5, right: 7.5),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                    FlatButton(
                        onPressed: () {
                          var _nome = data["nome$idCarac3"];
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Especificidade(_nome)));
                        },
                        child: Text(
                          data["nome$idCarac3"],
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ))
                  ]))
            ]));
  }
}

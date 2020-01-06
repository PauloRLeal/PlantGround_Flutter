import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MaterialApp(
    title: 'Receita',
    debugShowCheckedModeBanner: false,
  ));
}

class Receita extends StatefulWidget {
  final idCarac;
  Receita(this.idCarac);
  @override
  _Receita createState() => _Receita(idCarac);
}

class _Receita extends State<Receita> {
  final idCarac2;
  _Receita(this.idCarac2);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        appBar: AppBar(
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
                stream: Firestore.instance.collection("receitas").snapshots(),
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
                          snapshot.data.documents[index].data["text$idCarac2"] != null ?
                           a = TextCaracteristicasGerais(
                              snapshot.data.documents[index].data, idCarac2) : a = null;
                          return a;
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

class TextCaracteristicasGerais extends StatelessWidget {
  final Map<String, dynamic> data;
  final idCarac3;

  TextCaracteristicasGerais(this.data, this.idCarac3);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text(
      data["text$idCarac3"],
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 24.0, color: Colors.black),
    ));
  }
}

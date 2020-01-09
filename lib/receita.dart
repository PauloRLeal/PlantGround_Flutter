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
                          return snapshot.data.documents[index].data["text$idCarac2"] != null ?
                          TextReceita(
                              snapshot.data.documents[index].data, idCarac2) : Text("");
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

class TextReceita extends StatelessWidget {
  final Map<String, dynamic> data;
  final idCarac3;

  TextReceita(this.data, this.idCarac3);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[Container(
          child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(data["img$idCarac3"]),
                minRadius: 150.0,
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 15.0),
        child: Text(
      data["text$idCarac3"],
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 24.0, color: Colors.black),
    ))],);
  }
}

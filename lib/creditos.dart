import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Créditos',
    debugShowCheckedModeBanner: false,
    home: Creditos(),
  ));
}

class Creditos extends StatefulWidget {
  @override
  _CreditosState createState() => _CreditosState();
}

class _CreditosState extends State<Creditos> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          title: Text("Créditos"),
          centerTitle: true,
          elevation:
              Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: StreamBuilder(
                stream: Firestore.instance.collection("creditos").snapshots(),
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
                          return ButtonsClassificacao(
                              snapshot.data.documents[index].data);
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

class ButtonsClassificacao extends StatelessWidget {
  final Map<String, dynamic> data;

  ButtonsClassificacao(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
      child: Text(
      data["nome"],
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 24.0, color: Colors.black),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MaterialApp(
    title: 'Caracteristicas gerais',
    debugShowCheckedModeBanner: false,
  ));
}

class CaracteristicasGerais extends StatefulWidget {
  final idCarac;
  CaracteristicasGerais(this.idCarac);
  @override
  _CaracteristicasGeraisState createState() =>
      _CaracteristicasGeraisState(idCarac);
}

class _CaracteristicasGeraisState extends State<CaracteristicasGerais> {
  final idCarac2;
  _CaracteristicasGeraisState(this.idCarac2);
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
                stream: Firestore.instance
                    .collection("caracteristicasgerais")
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
                          return TextCaracteristicasGerais(
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

class TextCaracteristicasGerais extends StatelessWidget {
  final Map<String, dynamic> data;
  final idCarac3;

  TextCaracteristicasGerais(this.data, this.idCarac3);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text(
      data[idCarac3],
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 24.0, color: Colors.black),
    ));
  }
}

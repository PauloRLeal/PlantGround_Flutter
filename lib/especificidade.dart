import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MaterialApp(
    title: "PlantGround",
    debugShowCheckedModeBanner: false,
  ));
}

var _check = false;

class Especificidade extends StatefulWidget {
  final idCarac;
  Especificidade(this.idCarac);
  @override
  _EspecificidadeState createState() =>
      _EspecificidadeState(idCarac);
}

class _EspecificidadeState extends State<Especificidade> {
  final idCarac2;
  _EspecificidadeState(this.idCarac2);
  @override
  @override
  void initState() { 
    super.initState();
    _check = false;
  }
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          title: Text(
          idCarac2,
          style: TextStyle(
              fontSize: 24.0,
              color: Colors.white),
        ),
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
                          if(snapshot.hasData){
                            if(snapshot.data.documents[index].data["text$idCarac2"] != null){
                              _check = true;
                              return TextEspecificidade(
                              snapshot.data.documents[index].data, idCarac2);
                            }else{
                              if(_check == false){
                                _check = true;
                              return Center(child: Text("Sem resposta do servidor no momento.", style: TextStyle(fontSize: 24, color: Colors.black),));}else{
                                return Center();
                              }
                            }
                          }else{
                              return Center(child: Text("Sem resposta do servidor no momento.", style: TextStyle(fontSize: 24, color: Colors.black),));
                            }
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

class TextEspecificidade extends StatelessWidget {
  final Map<String, dynamic> data;
  final idCarac3;

  TextEspecificidade(this.data, this.idCarac3);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: <Widget>[
      Container(
          child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
              child: CircleAvatar(
                backgroundImage: data["img$idCarac3"] != null ? NetworkImage(data["img$idCarac3"]) : Icon(Icons.autorenew),
                minRadius: 150.0,
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 15.0),
        child: Text(
      data["text$idCarac3"] != null ? data["text$idCarac3"] : "Sem resposta do servidor no momento.",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 24.0, color: Colors.black),
    ))
    ]));
  }
}


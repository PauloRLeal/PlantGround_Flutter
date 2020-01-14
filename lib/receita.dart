import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MaterialApp(
    title: "PlantGround",
    debugShowCheckedModeBanner: false,
  ));
}

var _check = false;

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
                          if(snapshot.hasData){
                            if(snapshot.data.documents[index].data["text$idCarac2"] != null){
                              _check = true;
                              return TextReceita(
                              snapshot.data.documents[index].data, idCarac2);
                            }else{
                              if(_check == false){
                                _check = true;
                              return Center();}else{
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
                backgroundImage: data["img$idCarac3"] != null ? NetworkImage(data["img$idCarac3"]) : NetworkImage("https://repository-images.githubusercontent.com/205373971/def40d80-cb4c-11e9-971a-7434089990ed"),
                minRadius: 150.0,
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 30.0),
        child: Text(
      data["text$idCarac3"] != null ? data["text$idCarac3"]["title"] + "\n\n" + data["text$idCarac3"]["ingredientes"] + "\n\n" + data["text$idCarac3"]["preparo"]: "Sem resposta do servidor no momento",
      textAlign: TextAlign.justify,
      style: TextStyle(fontSize: 24.0, color: Colors.black),
    )),
    SizedBox(
      height: 30,
    ), ],);
  }
}

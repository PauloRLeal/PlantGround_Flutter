import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plantground/receita.dart';

void main() {
  runApp(MaterialApp(
    title: 'Possiveis Receitas',
    debugShowCheckedModeBanner: false,
  ));
}

class PossiveisReceitas extends StatefulWidget {
  final idCarac;
  PossiveisReceitas(this.idCarac);
  @override
  _PossiveisReceitas createState() => _PossiveisReceitas(idCarac);
}

class _PossiveisReceitas extends State<PossiveisReceitas> {
  final idCarac2;
  _PossiveisReceitas(this.idCarac2);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        appBar: AppBar(
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
                    .collection("possiveisreceitas")
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
                            if(snapshot.data != null){
                              return TextReceitasPossiveis(
                              snapshot.data.documents[index].data, idCarac2);
                            }else{
                              return Center(child: CircularProgressIndicator());
                            }
                          }else{
                              return Center(child: CircularProgressIndicator());
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

class TextReceitasPossiveis extends StatelessWidget {
  final Map<String, dynamic> data;
  final idCarac3;

  TextReceitasPossiveis(this.data, this.idCarac3);

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
                                  builder: (context) => Receita(_nome)));
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

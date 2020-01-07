import 'package:flutter/material.dart';
import 'package:plantground/caracteristicas_gerais.dart';
import 'package:plantground/exemplares.dart';
import 'package:plantground/receitas_possiveis.dart';

void main() {
  runApp(MaterialApp(
    title: 'Tópicos',
    debugShowCheckedModeBanner: false,
  ));
}

class Topicos extends StatelessWidget {
  final idTop;
  Topicos(this.idTop);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        title: Text(
          idTop,
          style: TextStyle(
              fontSize: 24.0,
              color: Colors.white),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(15.0, 0.0, 10.0, 60.0),
            child: FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CaracteristicasGerais(idTop)));
              },
              child: Text(
                "CARACTERÍSTICAS GERAIS",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.0, bottom: 30.0),
            child: FlatButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Exemplares(idTop)));
              },
              child: Text(
                "EXEMPLARES",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.0, bottom: 30.0),
            child: FlatButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Exemplares(idTop)));
              },
              child: Container(
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
                                          PossiveisReceitas(idTop)));
                            },
                            child: Text(
                              "RECEITAS",
                              style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            )),
                      ),
                    ]),
              )
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:PlantGround/caracteristicas_gerais.dart';
import 'package:PlantGround/exemplares.dart';
import 'package:PlantGround/receitas_possiveis.dart';

void main() {
  runApp(MaterialApp(
    title: "PlantGround",
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: OutlineButton(
              borderSide: BorderSide(color: Colors.greenAccent),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CaracteristicasGerais(idTop)));
                },
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Características Gerais",
                      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: 280,
                      child: Divider(color: Colors.blueAccent,))
                  ],
                ),
              ),
          ),
            SizedBox(
              height: 50,
            ),
          Center(
            child: OutlineButton(
              borderSide: BorderSide(color: Colors.greenAccent),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Exemplares(idTop)));
                },
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Exemplares",
                      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: 150,
                      child: Divider(color: Colors.blueAccent,))
                  ],
                ),
              ),
          ),
            SizedBox(
              height: 50,
            ),
          Center(
            child: OutlineButton(
              borderSide: BorderSide(color: Colors.greenAccent),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PossiveisReceitas(idTop)));
                },
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Receitas",
                      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: 150,
                      child: Divider(color: Colors.blueAccent,))
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }
}

/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantground/creditos.dart';
import 'package:plantground/topicos.dart';


void main() {
  print("deubom");
  runApp(MaterialApp(
    title: 'PlantGround',
    debugShowCheckedModeBanner: false,
    home: MenuPrincipal(),
  ));
}

class MenuPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text(
          "PlantGround",
          style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.black45),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 0.0, bottom: 30.0),
              child: FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Topicos()));
                },
                child: Text(
                  "ALGAS",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0.0, bottom: 30.0),
              child: FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Topicos()));
                },
                child: Text(
                  "BRIÓFITAS",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0.0, bottom: 30.0),
              child: FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Topicos()));
                },
                child: Text(
                  "PTERIDÓFITAS",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0.0, bottom: 30.0),
              child: FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Topicos()));
                },
                child: Text(
                  "GIMNOSPERMA",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0.0, bottom: 30.0),
              child: FlatButton(
                onPressed: () {
                  Firestore.instance.collection("Algas").document("dados").setData({"tcha":"prima"});
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Creditos()));
                },
                child: Text(
                  "CRÉDITOS",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/

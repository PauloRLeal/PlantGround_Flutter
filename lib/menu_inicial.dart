import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plantground/drawer.dart';
import 'package:plantground/topicos.dart';

void main() {
  runApp(MaterialApp(
    title: "PlantGround",
    debugShowCheckedModeBanner: false,
    home: MenuInicial(),
  ));
}

class MenuInicial extends StatefulWidget {
  @override
  _MenuInicialState createState() => _MenuInicialState();
}

class _MenuInicialState extends State<MenuInicial> {
  @override
  Widget build(BuildContext context) {
    getDadosUser();
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          title: Text(
          "PlantGround",
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
                stream:
                    Firestore.instance.collection("classificacao").snapshots(),
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
                              return Classificacao(
                              snapshot.data.documents[index].data);
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
            ),
          ],
        ),
        drawer: MDrawer(),
      ),
    );
  }
}

class Classificacao extends StatelessWidget {
  final Map<String, dynamic> data;

  Classificacao(this.data);

  @override
  Widget build(BuildContext context) {
    void onPress(String id) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Topicos(id)));
    }

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
                    onPressed: () => onPress(data["nome"]),
                    child: Text(
                      data["nome"],
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}

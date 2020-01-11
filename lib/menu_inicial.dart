import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:PlantGround/drawer.dart';
import 'package:PlantGround/topicos.dart';

void main() {
  runApp(MaterialApp(
    title: "PlantGround",
    debugShowCheckedModeBanner: false,
    home: MenuInicial(),
  ));
}

var _check = false;

class MenuInicial extends StatefulWidget {
  @override
  _MenuInicialState createState() => _MenuInicialState();
}

class _MenuInicialState extends State<MenuInicial> {
  @override
  @override
  void initState() { 
    super.initState();
    _check = false;
  }
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
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          elevation:
              Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        ),
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: StreamBuilder(
                    stream: Firestore.instance
                        .collection("classificacao")
                        .snapshots(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        default:
                          return Center(
                            child: ListView.builder(
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (context, index) {
                                if (snapshot.hasData) {
                                  if (snapshot.data.documents[index].data["nome"] != null && snapshot.data.documents[index].data["img"] != null) {
                                    _check = true;
                                    return Classificacao(
                                        snapshot.data.documents[index].data);
                                  } else {
                                    if(_check == false){
                                      _check = true;
                                    return Center(
                                        child: Text(
                                      "Sem resposta do servidor no momento.",
                                      style: TextStyle(
                                          fontSize: 24, color: Colors.black),
                                    ));}else{
                                      return Center();
                                    }
                                  }
                                } else {
                                  return Center(
                                      child: Text(
                                    "Sem resposta do servidor no momento.",
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.black),
                                  ));
                                }
                              },
                            ),
                          );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
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
      margin: const EdgeInsets.only(top: 4),
      child: FlatButton(
          onPressed: () => onPress(data["nome"]),
          child: SizedBox(
            height: 150,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(data["img"])
                    )
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: <Color>[
                        Colors.white.withAlpha(0),
                        Colors.white38,
                        Colors.white
                      ],
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Text(
                      data["nome"] != null ? data["nome"] : "",
                      style:
                          TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}

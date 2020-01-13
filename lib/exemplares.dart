import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:PlantGround/especificidade.dart';

void main() {
  runApp(MaterialApp(
    title: "PlantGround",
    debugShowCheckedModeBanner: false,
  ));
}

var _check = false;

class Exemplares extends StatefulWidget {
  final idCarac;

  Exemplares(this.idCarac);
  @override
  _Exemplares createState() => _Exemplares(idCarac);
}

class _Exemplares extends State<Exemplares> {
  final idCarac2;
  _Exemplares(this.idCarac2);
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
            style: TextStyle(fontSize: 24.0, color: Colors.white),
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
                stream: Firestore.instance.collection("exemplares").snapshots(),
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
                          if (snapshot.hasData) {
                            if (snapshot.data.documents[index]
                                    .data["nome$idCarac2"] !=
                                null && snapshot.data.documents[index]
                                    .data["img$idCarac2"] != null) {
                                  _check = true;
                              return TextCaracteristicas(
                                  snapshot.data.documents[index].data,
                                  idCarac2);
                            } else {
                              if (_check == false) {
                                _check = true;
                                return Center();
                              }else{
                                _check = true;
                                return Center();
                              }
                            }
                          } else {
                            _check = true;
                            return Center(
                                child: Text(
                              "Sem resposta do servidor no momento.",
                              style:
                                  TextStyle(fontSize: 24, color: Colors.black),
                            ));
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

class TextCaracteristicas extends StatelessWidget {
  final Map<String, dynamic> data;
  final idCarac3;

  TextCaracteristicas(this.data, this.idCarac3);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      child: FlatButton(
        onPressed: (){
          Navigator.push(
          context, MaterialPageRoute(builder: (context) => Especificidade(data["nome$idCarac3"])));
        },
          child: SizedBox(
            height: 150,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(data["img$idCarac3"])
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
                      data["nome$idCarac3"] != null ? data["nome$idCarac3"] : "",
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
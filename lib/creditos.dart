import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:PlantGround/menu_inicial.dart';

void main() {
  runApp(MaterialApp(
    title: "PlantGround",
    debugShowCheckedModeBanner: false,
    home: Creditos(),
  ));
}

var _check = false;

class Creditos extends StatefulWidget {
  @override
  _CreditosState createState() => _CreditosState();
}

class _CreditosState extends State<Creditos> {
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                    IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
                      Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MenuInicial()));
                    },),
                    Expanded(child:Center(
                      child: Text(
                        "Sobre o PlantGround",
                        style: TextStyle(fontSize: 24.0, color: Colors.white),
                      ),
                    )),
                  ]),
          centerTitle: true,
          elevation:
              Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: StreamBuilder(
                stream: Firestore.instance.collection("creditos").snapshots(),
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
                            if(snapshot.data.documents[index].data["text"] != null){
                              _check = true;
                              return ButtonsClassificacao(
                              snapshot.data.documents[index].data);
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

class ButtonsClassificacao extends StatelessWidget {
  final Map<String, dynamic> data;

  ButtonsClassificacao(this.data);

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
              margin:
                  const EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
              child: CircleAvatar(
                backgroundImage: data["img"] != null ? NetworkImage(data["img"]) : Icon(Icons.autorenew),
                minRadius: 75.0,
              ),
            ),
          ],
        ),
      ),
      Container(
          margin: EdgeInsets.only(top: 30.0),
          child: Text(
            data["text"] != null ? data["text"] : "Sem resposta do servidor no momento.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24.0, color: Colors.black),
          )),
      Padding(
        padding: EdgeInsets.only(bottom: 50.0),
      ),
      Divider(
        height: 1.0,
      ),
    ]));
  }
}

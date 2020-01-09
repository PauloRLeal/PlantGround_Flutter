import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plantground/menu_inicial.dart';

void main() {
  runApp(MaterialApp(
    title: 'Créditos',
    debugShowCheckedModeBanner: false,
    home: Creditos(),
  ));
}

class Creditos extends StatefulWidget {
  @override
  _CreditosState createState() => _CreditosState();
}

class _CreditosState extends State<Creditos> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          title: Row(children: [
                    IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
                      Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MenuInicial()));
                    },),
                    Text(
                      "Tira Dúvidas",
                      style: TextStyle(fontSize: 24.0, color: Colors.white),
                    ),
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
                            if(snapshot.data != null){
                              return ButtonsClassificacao(
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
                backgroundImage: NetworkImage(data["img"]),
                minRadius: 75.0,
              ),
            ),
          ],
        ),
      ),
      Container(
          margin: EdgeInsets.only(top: 30.0),
          child: Text(
            data["text"],
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

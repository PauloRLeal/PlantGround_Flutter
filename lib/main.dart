import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plantground/chat_mensagens.dart';
import 'package:plantground/creditos.dart';
import 'package:plantground/topicos.dart';

void main() {
  runApp(MaterialApp(
    title: 'PlantGround',
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
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          title: Text("PlantGround"),
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
                          return ButtonsClassificacao(
                              snapshot.data.documents[index].data);
                        },
                      );
                  }
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              child: IconsComposer(),
            )
          ],
        ),
      ),
    );
  }
}

class IconsComposer extends StatefulWidget {
  IconsComposer({Key key}) : super(key: key);

  @override
  _IconsComposerState createState() => _IconsComposerState();
}

class _IconsComposerState extends State<IconsComposer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).accentColor),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: Theme.of(context).platform == TargetPlatform.iOS
              ? BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey[200])))
              : null,
          child: Row(
            children: <Widget>[
              Container(
                child: IconButton(
                  icon: Icon(
                    Icons.info,
                    color: Colors.greenAccent,
                    size: 30.0,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Creditos()));
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 120.0),
              ),
              Container(
                child: IconButton(
                  icon: Icon(Icons.chat, color: Colors.greenAccent, size: 30.0),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatMensagem()));
                  },
                ),
              )
            ],
          ),
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

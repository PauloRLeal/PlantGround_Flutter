import 'dart:io' as io;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    title: 'Chat Mensagens',
    debugShowCheckedModeBanner: false,
  ));
}

var _userId;
var _userName;
var _userPhotoUrl;

_getDadosUser() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  _userId = prefs.getString('userId');
  _userName = prefs.getString('displayName');
  _userPhotoUrl = prefs.getString('photoUrl');

}

void _sendMessage({String text, String imgUrl}) {
  Firestore.instance
      .collection("nummensagens")
      .getDocuments()
      .then((QuerySnapshot snapshot) {
    snapshot.documents.forEach((f) {
      Firestore.instance
          .collection("mensagens")
          .document(f.data["numero"].toString())
          .setData({
        "text": text,
        "imgUrl": imgUrl,
        "senderName": _userName,
        "senderPhotoUrl": _userPhotoUrl,
        "senderId": _userId,
        "idmensagem": f.data["numero"]
      });
      Firestore.instance
          .collection("nummensagens")
          .document("nummensagens")
          .updateData({"numero": (f.data["numero"] + 1)});
    });
  });
}

class ChatMensagem extends StatefulWidget {
  ChatMensagem({Key key}) : super(key: key);
  @override
  _ChatMensagemState createState() => _ChatMensagemState();
}

class _ChatMensagemState extends State<ChatMensagem> {
  @override
  Widget build(BuildContext context) {
    _getDadosUser();
    return Container(
        child: SafeArea(
            bottom: false,
            top: false,
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.greenAccent,
                  title: Text("PlantGround"),
                  centerTitle: true,
                  elevation: Theme.of(context).platform == TargetPlatform.iOS
                      ? 0.0
                      : 4.0,
                ),
                body: Column(
                  children: <Widget>[
                    Expanded(
                      child: StreamBuilder(
                        stream: Firestore.instance
                            .collection("mensagens")
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
                                reverse: true,
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (context, index) {
                                  if (snapshot.data.documents[index].data !=
                                      null) {
                                    List r = snapshot.data.documents.reversed
                                        .toList();
                                    if (r[index].data["senderId"] == _userId){
                                      return MessageUser(r[index].data);
                                    }
                                    else{
                                      return Message(r[index].data);
                                    }
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                },
                              );
                          }
                        },
                      ),
                    ),
                    Divider(
                      height: 1.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                      ),
                      child: TextComposer(),
                    )
                  ],
                ))));
  }
}

class TextComposer extends StatefulWidget {
  TextComposer({Key key}) : super(key: key);

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  final _textController = TextEditingController();
  bool _isComposing = false;

  void _reset() {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: Theme.of(context).platform == TargetPlatform.iOS
            ? BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey[200])))
            : null,
        child: Row(
          children: <Widget>[
            Container(
              child: IconButton(
                  icon: Icon(Icons.photo_camera),
                  onPressed: () async {
                    io.File imgFile =
                        await ImagePicker.pickImage(source: ImageSource.camera);
                    if (imgFile == null) return;
                    StorageUploadTask task = FirebaseStorage.instance
                        .ref()
                        .child(_userId +
                            DateTime.now().millisecondsSinceEpoch.toString())
                        .putFile(imgFile);
                    StorageTaskSnapshot snap = await task.onComplete;
                    _sendMessage(imgUrl: await snap.ref.getDownloadURL());
                  }),
            ),
            Expanded(
              child: TextField(
                  controller: _textController,
                  decoration: InputDecoration.collapsed(
                      hintText: "Enviar uma Mensagem"),
                  onChanged: (text) {
                    setState(() {
                      _isComposing = text.length > 0;
                    });
                  },
                  onSubmitted: (text) {
                    _sendMessage(text: _textController.text);
                    _reset();
                  }),
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Theme.of(context).platform == TargetPlatform.iOS
                    ? CupertinoButton(
                        child: Text("Enviar"),
                        onPressed: _isComposing
                            ? () {
                                _sendMessage(text: _textController.text);
                                _reset();
                              }
                            : null,
                      )
                    : IconButton(
                        icon: Icon(Icons.send),
                        onPressed: _isComposing
                            ? () {
                                _sendMessage(text: _textController.text);
                                _reset();
                              }
                            : null,
                      ))
          ],
        ),
      ),
    );
  }
}

class Message extends StatelessWidget {
  final Map<String, dynamic> data;

  Message(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(data["senderPhotoUrl"]),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(data["senderName"],
                      style: Theme.of(context).textTheme.subhead),
                  Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: data["imgUrl"] != null
                          ? Image.network(data["imgUrl"], width: 250.0)
                          : Text(data["text"]))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MessageUser extends StatelessWidget {
  final Map<String, dynamic> data;

  MessageUser(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(data["senderName"],
                    style: Theme.of(context).textTheme.subhead),
                Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: data["imgUrl"] != null
                        ? Image.network(data["imgUrl"], width: 250.0)
                        : Text(data["text"]))
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 16.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(data["senderPhotoUrl"]),
            ),
          ),
        ],
      ),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:plantground/chat_mensagens.dart';
import 'package:plantground/creditos.dart';
import 'package:shared_preferences/shared_preferences.dart';

var _userName;
var _userPhotoUrl;
var _userEmail;

getDadosUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  _userName = prefs.getString('displayName');
  _userPhotoUrl = prefs.getString('photoUrl');
  _userEmail = prefs.getString('userEmail');
}

class MDrawer extends StatelessWidget {
  final String title;

  MDrawer({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    getDadosUser();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    minRadius: 5,
                    maxRadius: 40,
                    backgroundImage: _userPhotoUrl != null ? NetworkImage(_userPhotoUrl) : null,
                  ),
                  Container(margin: EdgeInsets.only(top: 5),child:Text(_userName != null ? _userName : "", style: TextStyle(fontSize: 14),)),
                  Container(margin: EdgeInsets.only(top: 5),child:Text(_userEmail != null ? _userEmail : "", style: TextStyle(fontSize: 17),))
                ],
              ),
            decoration: BoxDecoration(
              color: Colors.greenAccent,
            ),
          ),
          ListTile(
            title: Row(
              children: <Widget>[
                Container(
                    child: Icon(
                      Icons.chat,
                      color: Colors.greenAccent,
                    ),
                    margin: EdgeInsets.only(
                      right: 15.0,
                    )),
                Text("Chat Tira Dúvidas", style: TextStyle(fontSize: 15),)
              ],
            ),
            onTap: () {
              Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatMensagem()));
            },
          ),
          ListTile(
            title: Row(
              children: <Widget>[
                Container(
                    child: Icon(
                      Icons.info,
                      color: Colors.greenAccent,
                    ),
                    margin: EdgeInsets.only(
                      right: 15.0,
                    )),
                Text("Sobre o App", style: TextStyle(fontSize: 15),)
              ],
            ),
            onTap: () {
              Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Creditos()));
            },
          ),
        ],
      ),
    );
  }
}

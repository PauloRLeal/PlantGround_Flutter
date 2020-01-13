import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:PlantGround/drawer.dart';
import 'package:PlantGround/menu_inicial.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    title: "PlantGround",
    debugShowCheckedModeBanner: false,
    home: Login(),
  ));
}

final googleSignIn = GoogleSignIn();
final auth = FirebaseAuth.instance;
var _currentUser;

Future<GoogleSignInAccount> ensureLoggedIn() async {
  GoogleSignInAccount user = googleSignIn.currentUser;
  _currentUser = user;
  if (user == null) {
    user = await googleSignIn.signInSilently();
    _currentUser = user;
  }
  if (user == null) {
    user = await googleSignIn.signIn();
    _currentUser = user;
  }

  if (await auth.currentUser() == null) {
    GoogleSignInAuthentication credentials =
        await googleSignIn.currentUser.authentication;
    await auth.signInWithCredential(GoogleAuthProvider.getCredential(
        idToken: credentials.idToken, accessToken: credentials.accessToken));
  }
  return _currentUser;
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
@override
@override
  void initState() {
    super.initState();
    ensureLoggedIn().then((user){
      if(user != null){
        print(user);
        salvarDadosUser();
        getDadosUser();
         Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MenuInicial()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(child: CircularProgressIndicator(),)
    );
  }
}
salvarDadosUser() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('userId', _currentUser.id);
  await prefs.setString('displayName', _currentUser.displayName);
  await prefs.setString('photoUrl', _currentUser.photoUrl);
  await prefs.setString('userEmail', _currentUser.email);
  
}
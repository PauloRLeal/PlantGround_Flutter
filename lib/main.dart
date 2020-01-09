import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plantground/drawer.dart';
import 'package:plantground/menu_inicial.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    title: "Login",
    debugShowCheckedModeBanner: false,
    home: Login(),
  ));
}

final googleSignIn = GoogleSignIn();
final auth = FirebaseAuth.instance;
var _currentUser;

Future<GoogleSignInAccount> _ensureLoggedIn() async {
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

  bool _loading;

@override
  void initState() {
    super.initState();
    _loading = true;
    _ensureLoggedIn().then((user){
      if(user != null){
        _loading = false;
        _salvarDadosUser();
        getDadosUser();
         Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MenuInicial()));
      }
    });
  }

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_loading ? Center(child: CircularProgressIndicator(),) : Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(size: 150),
              SizedBox(height: 50),
              OutlineButton(
      splashColor: Colors.grey,
      onPressed: () async {
        await _ensureLoggedIn();
        _salvarDadosUser();
        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MenuInicial()));
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    )
            ],
          ),
        ),
      ),
    );
  }
}
_salvarDadosUser() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('userId', _currentUser.id);
  await prefs.setString('displayName', _currentUser.displayName);
  await prefs.setString('photoUrl', _currentUser.photoUrl);
  await prefs.setString('userEmail', _currentUser.email);
  
}
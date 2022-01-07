
import 'dart:io';

import 'package:bearpanel/screens/authenticate/sing_in.dart';
import 'package:bearpanel/screens/home/start_page.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }
  _checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      return 0;
    } else {
      return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser != null) {
      return HomePage();
    } else {
      return SignIn(toggleView: toggleView);
    }

    /*if (showSignIn) {
      if (_checkInternetConnectivity() == 0) {
        _showDialog();
      } else {
        return SignIn(toggleView: toggleView);
      }
    } else {
      if (_checkInternetConnectivity() == 0) {
        _showDialog();
      } else {
           SignUp(toggleView: toggleView);
      }
    }*/
  }
  _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(top: 235, bottom: 235),
            child:  AlertDialog(
              content:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Icon(
                    Icons.wifi_off,
                    color: Colors.black,
                    size: 50.0,
                  ),
                  SizedBox(height: 5),
                  Text('Sem conexão',textAlign: TextAlign.center,style:TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),],
              ),
              actions: <Widget>[
                TextButton(
                    child: Text('Ok'),
                    onPressed: () {exit(0);}
                ),
              ],
            ),
          );
        }
    );
  }
}




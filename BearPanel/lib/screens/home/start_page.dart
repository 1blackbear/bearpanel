import 'package:bearpanel/models/user.dart';
import 'package:bearpanel/screens/widgets/loading.dart';
import 'package:bearpanel/services/auth.dart';
import 'package:bearpanel/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final AuthService _auths = AuthService();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => {
        _auths.signOut()
      },
      child: Text("Home Page"),);
    /*return StreamBuilder(
      stream: DatabaseService(uid: user!.uid).userData,
        builder: (context, snapshot) {
          UserData? userData = snapshot.data as UserData?;
          if (snapshot.hasData) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text("Home Page")
                  ],
                ),
              ),
            );
          } else {
            return TextButton(
              onPressed: () => {
                _auths.signOut()
              },
              child: Text("Home Page"),);
          }
        }
    );*/
  }
}

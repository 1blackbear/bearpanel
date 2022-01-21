import 'package:bearpanel/core/app_navigator.dart';
import 'package:bearpanel/screens/widgets/app_bar_login.dart';
import 'package:bearpanel/services/auth.dart';
import 'package:bearpanel/services/auth_file.dart';
import 'package:flutter/material.dart';

//ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  AuthService auth;
  ProfilePage({Key? key, required this.auth}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBarLoginWidget(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(top: 15),
              children: [
                ListTile(
                  title: Text('Dados Pessoais'),
                  leading: Icon(Icons.person),
                ),
                ListTile(
                  title: Text('Histórico'),
                  leading: Icon(Icons.history),
                ),
                ListTile(
                  title: Text('Configurações'),
                  leading: Icon(Icons.settings),
                ),
                ListTile(
                  title: Text('Sair'),
                  leading: Icon(Icons.logout),
                  onTap: () async {
                    await widget.auth.signOut();
                    if (AppNavigator.activate_detail_static)
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) => AuthFile()),(route) => false);
                  },
                ),
              ],
            ),
        )
      ],
    );
  }
}



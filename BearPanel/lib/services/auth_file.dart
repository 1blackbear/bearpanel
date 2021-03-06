import 'package:bearpanel/core/app_navigator.dart';
import 'package:bearpanel/screens/authenticate/sing_in.dart';
import 'package:bearpanel/screens/widgets/app_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth.dart';

class AuthFile extends StatefulWidget {
  const AuthFile({Key? key}) : super(key: key);

  @override
  _AuthFileState createState() => _AuthFileState();
}

class _AuthFileState extends State<AuthFile> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
      if (auth.isLoading)
        return Loading();
      else if (auth.user_state == null)
        return SignIn();
      else
        return NavigatorBase(auth: auth);
  }
}

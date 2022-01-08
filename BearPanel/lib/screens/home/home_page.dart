import 'package:bearpanel/models/user.dart';
import 'package:bearpanel/screens/widgets/app_bar_home.dart';
import 'package:bearpanel/services/auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  UserData data;
  AuthService auth;
  HomePage({Key? key, required this.data, required this.auth}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pageViewController = PageController();

  @override
  void dispose() {
    super.dispose();
    pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      AppBarHome(
        user: widget.data,
        auth: widget.auth,
      ),
    ]);
  }
}
